import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/process_model.dart';
import '../services/storage_service.dart';
import 'filter_provider.dart';

class ProcessNotifier extends StateNotifier<List<Process>> {
  ProcessNotifier() : super([]) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await loadForUser(null);
    } catch (e) {
      // Tratar erro silenciosamente - dados de fallback já fornecidos por StorageService
    }
  }

  Future<void> loadForUser(String? userId) async {
    try {
      final processes = await StorageService.loadProcesses();
      state = processes
          .where((p) => p.isGlobal || p.ownerId == userId)
          .toList();
    } catch (e) {
      state = [];
      rethrow;
    }
  }

  /// Adicionar novo processo
  Future<void> addProcess(Process process) async {
    try {
      final updatedList = [...state, process];
      await StorageService.saveProcesses(updatedList);
      state = updatedList;
    } catch (e) {
      rethrow;
    }
  }

  /// Atualizar processo existente
  Future<void> updateProcess(Process process) async {
    try {
      final index = state.indexWhere((p) => p.id == process.id);
      if (index == -1) {
        throw Exception('Processo não encontrado');
      }

      final updatedList = [...state];
      updatedList[index] = process;
      await StorageService.saveProcesses(updatedList);
      state = updatedList;
    } catch (e) {
      rethrow;
    }
  }

  /// Deletar processo
  Future<void> deleteProcess(String id) async {
    try {
      final updatedList = state.where((p) => p.id != id).toList();
      await StorageService.saveProcesses(updatedList);
      state = updatedList;
    } catch (e) {
      rethrow;
    }
  }
}

// Provider para processos
final processProvider = StateNotifierProvider<ProcessNotifier, List<Process>>((
  ref,
) {
  return ProcessNotifier();
});

// Provider para loading state (simplificado)
final processLoadingProvider = Provider<bool>((ref) {
  return ref.watch(processProvider).isEmpty;
});

/// Visualização filtrada de processos de acordo com o estado atual de filtros.
final filteredProcessProvider = Provider<List<Process>>((ref) {
  final procs = ref.watch(processProvider);
  final filter = ref.watch(filterProvider).processQuery.trim().toLowerCase();
  if (filter.isEmpty) return procs;

  return procs.where((p) {
    final numero = p.numero.toLowerCase();
    final cliente = p.cliente.toLowerCase();
    final tipo = p.tipo.toLowerCase();
    final status = p.status.toLowerCase();
    final descricao = p.descricao?.toLowerCase() ?? '';
    final observacoes = p.observacoes?.toLowerCase() ?? '';
    final cpf = p.cpfCnpjCliente?.toLowerCase() ?? '';
    final contato = p.contatoCliente?.toLowerCase() ?? '';

    return numero.contains(filter) ||
        cliente.contains(filter) ||
        tipo.contains(filter) ||
        status.contains(filter) ||
        descricao.contains(filter) ||
        observacoes.contains(filter) ||
        cpf.contains(filter) ||
        contato.contains(filter);
  }).toList();
});
