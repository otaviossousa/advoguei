import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/document_model.dart';
import '../providers/auth_provider.dart';
import '../providers/document_provider.dart';
import '../providers/filter_provider.dart';
import '../widgets/document_card.dart';
import 'document_detail_screen.dart';
import 'document_form_screen.dart';

class DocumentListScreen extends ConsumerStatefulWidget {
  const DocumentListScreen({super.key});

  @override
  ConsumerState<DocumentListScreen> createState() => _DocumentListScreenState();
}

class _DocumentListScreenState extends ConsumerState<DocumentListScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final initial = ref.read(filterProvider).documentQuery;
    _controller = TextEditingController(text: initial);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final documents = ref.watch(filteredDocumentProvider);
    final isLoading = ref.watch(documentLoadingProvider);

    final currentUser = ref.watch(authProvider);
    final isReadOnly = currentUser?.id == 'caua';

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller,
                  onChanged: (value) {
                    // atualizar filtro em tempo real
                    ref.read(filterProvider.notifier).setDocumentQuery(value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Buscar ou filtrar documentos...',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.filter_list),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Lista de documentos
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : documents.isEmpty
                ? const Center(
                    child: Text('Nenhum documento encontrado'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final doc = documents[index];
                      return DocumentCard(
                        documento: doc,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DocumentDetailScreen(documento: doc),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: isReadOnly
          ? null
          : FloatingActionButton(
              onPressed: () async {
                final novoDocumento = await Navigator.push<Document>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DocumentFormScreen(),
                  ),
                );

                if (novoDocumento != null) {
                  // Documento já foi salvo através do provider
                }
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add, color: Colors.white),
            ),
    );
  }
}
