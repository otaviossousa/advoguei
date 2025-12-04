import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../data/process_repository.dart';
import '../models/process_model.dart';

class ProcessListNotifier extends StateNotifier<List<Process>> {
  final ProcessRepository _repo;
  ProcessListNotifier(this._repo) : super([]);

  Future<void> loadAllForUser(String? userId) async {
    try {
      final all = await _repo.loadAll();
      final filtered = all
          .where((p) => p.isGlobal || p.ownerId == userId)
          .toList();
      state = filtered;
    } catch (e) {
      state = [];
      rethrow;
    }
  }

  Future<void> add(Process p) async {
    final newP = Process(
      id: const Uuid().v4(),
      numero: p.numero,
      cliente: p.cliente,
      tipo: p.tipo,
      status: p.status,
      dataAbertura: p.dataAbertura,
      cpfCnpjCliente: p.cpfCnpjCliente,
      contatoCliente: p.contatoCliente,
      descricao: p.descricao,
      valorCausa: p.valorCausa,
      comarca: p.comarca,
      vara: p.vara,
      nomeJuiz: p.nomeJuiz,
      observacoes: p.observacoes,
      ownerId: p.ownerId,
      isGlobal: p.isGlobal,
    );
    final all = await _repo.loadAll();
    all.add(newP);
    await _repo.saveAll(all);
    await loadAllForUser(newP.ownerId);
  }
}

final processRepositoryProvider = Provider<ProcessRepository>(
  (ref) => ProcessRepository(),
);
final processListProvider =
    StateNotifierProvider<ProcessListNotifier, List<Process>>((ref) {
      final repo = ref.read(processRepositoryProvider);
      return ProcessListNotifier(repo);
    });
