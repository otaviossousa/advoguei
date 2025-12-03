import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/document_model.dart';
import '../services/storage_service.dart';

class DocumentNotifier extends StateNotifier<List<Document>> {
  DocumentNotifier() : super([]) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final documents = await StorageService.loadDocuments();
      state = documents;
    } catch (e) {
      // Silently handle error - fallback data already provided by StorageService
    }
  }

  /// Adicionar novo documento
  Future<void> addDocument(Document document) async {
    try {
      final updatedList = [...state, document];
      await StorageService.saveDocuments(updatedList);
      state = updatedList;
    } catch (e) {
      rethrow;
    }
  }

  /// Atualizar documento existente
  Future<void> updateDocument(Document document) async {
    try {
      final index = state.indexWhere((d) => d.id == document.id);
      if (index == -1) {
        throw Exception('Documento não encontrado');
      }

      final updatedList = [...state];
      updatedList[index] = document;
      await StorageService.saveDocuments(updatedList);
      state = updatedList;
    } catch (e) {
      rethrow;
    }
  }

  /// Deletar documento
  Future<void> deleteDocument(String id) async {
    try {
      final updatedList = state.where((d) => d.id != id).toList();
      await StorageService.saveDocuments(updatedList);
      state = updatedList;
    } catch (e) {
      rethrow;
    }
  }
}

// Provider para documentos
final documentProvider =
    StateNotifierProvider<DocumentNotifier, List<Document>>((ref) {
      return DocumentNotifier();
    });

// Provider para loading state (simplificado)
final documentLoadingProvider = Provider<bool>((ref) {
  return ref.watch(documentProvider).isEmpty;
});
