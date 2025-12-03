import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/process_model.dart';
import '../services/storage_service.dart';

class ProcessNotifier extends StateNotifier<List<Process>> {
  ProcessNotifier() : super([]) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final processes = await StorageService.loadProcesses();
      state = processes;
    } catch (e) {
      // Silently handle error - fallback data already provided by StorageService
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
