import 'package:flutter/material.dart';

import '../data/document_data.dart';
import '../models/document_model.dart';
import '../widgets/document_card.dart';
import 'document_form_screen.dart';

class DocumentListScreen extends StatelessWidget {
  const DocumentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final documents = DocumentData.getAllDocuments();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
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
            child: documents.isEmpty
                ? const Center(child: Text('Nenhum documento encontrado'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final doc = documents[index];
                      return DocumentCard(
                        documento: doc,
                        onTap: () {},
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final novoDocumento = await Navigator.push<Document>(
            context,
            MaterialPageRoute(
              builder: (context) => const DocumentFormScreen(),
            ),
          );

          if (novoDocumento != null) {}
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
