import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../data/document_repository.dart';
import '../models/document_model.dart';

class DocumentListNotifier extends StateNotifier<List<Document>> {
  final DocumentRepository _repo;
  DocumentListNotifier(this._repo) : super([]);

  Future<void> loadAllForUser(String? userId) async {
    try {
      final all = await _repo.loadAll();
      final filtered = all
          .where((d) => d.isGlobal || d.ownerId == userId)
          .toList();
      state = filtered;
    } catch (e) {
      state = [];
      rethrow;
    }
  }

  Future<void> add(Document doc) async {
    final newDoc = Document(
      id: const Uuid().v4(),
      nome: doc.nome,
      tipo: doc.tipo,
      data: doc.data,
      clienteVinculado: doc.clienteVinculado,
      processoVinculado: doc.processoVinculado,
      observacao: doc.observacao,
      ownerId: doc.ownerId,
      isGlobal: doc.isGlobal,
    );
    final all = await _repo.loadAll();
    all.add(newDoc);
    await _repo.saveAll(all);
    await loadAllForUser(newDoc.ownerId);
  }
}

final documentRepositoryProvider = Provider<DocumentRepository>(
  (ref) => DocumentRepository(),
);
final documentListProvider =
    StateNotifierProvider<DocumentListNotifier, List<Document>>((ref) {
      final repo = ref.read(documentRepositoryProvider);
      return DocumentListNotifier(repo);
    });
