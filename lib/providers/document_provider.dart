import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/document_model.dart';
import '../services/storage_service.dart';
import 'filter_provider.dart';

class DocumentNotifier extends StateNotifier<List<Document>> {
  DocumentNotifier() : super([]) {
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
      final documents = await StorageService.loadDocuments();
      state = documents
          .where((d) => d.isGlobal || d.ownerId == userId)
          .toList();
    } catch (e) {
      state = [];
      rethrow;
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
    // Edição de documentos foi desabilitada nesta versão.
    // Se algum código tentar chamar esta função, lançamos um erro claro.
    throw UnsupportedError('Editar documento está desabilitado.');
  }

  /// Deletar documento
  Future<void> deleteDocument(String id) async {
    // Remoção de documentos foi desabilitada nesta versão.
    throw UnsupportedError('Excluir documento está desabilitado.');
  }
}

// Provider para documentos
final documentProvider =
    StateNotifierProvider<DocumentNotifier, List<Document>>((ref) {
      return DocumentNotifier();
    });

final documentLoadingProvider = Provider<bool>((ref) {
  return ref.watch(documentProvider).isEmpty;
});

/// Visualização filtrada de documentos de acordo com o estado atual de filtros.
final filteredDocumentProvider = Provider<List<Document>>((ref) {
  final docs = ref.watch(documentProvider);
  final filter = ref.watch(filterProvider).documentQuery.trim().toLowerCase();
  if (filter.isEmpty) return docs;

  return docs.where((d) {
    final nome = d.nome.toLowerCase();
    final tipo = d.tipo.toLowerCase();
    final cliente = (d.clienteVinculado ?? []).join(' ').toLowerCase();
    final processo = (d.processoVinculado ?? []).join(' ').toLowerCase();
    final obs = d.observacao?.toLowerCase() ?? '';
    return nome.contains(filter) ||
        tipo.contains(filter) ||
        cliente.contains(filter) ||
        processo.contains(filter) ||
        obs.contains(filter);
  }).toList();
});
