import 'package:flutter/material.dart';

import '../data/constants.dart';
import '../data/document_data.dart';
import '../models/document_model.dart';
import '../widgets/document_card.dart';
import 'document_form_screen.dart';

class DocumentListScreen extends StatefulWidget {
  const DocumentListScreen({super.key});

  @override
  State<DocumentListScreen> createState() => _DocumentListScreenState();
}

class _DocumentListScreenState extends State<DocumentListScreen> {
  String _searchQuery = '';
  String? _selectedTipo;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final documents = DocumentData.getAllDocuments();

    // Filtrar documentos
    final filteredDocs = documents.where((doc) {
      final matchesSearch = doc.nome.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      final matchesTipo = _selectedTipo == null || doc.tipo == _selectedTipo;
      final matchesDate =
          _selectedDate == null ||
          (doc.data.day == _selectedDate!.day &&
              doc.data.month == _selectedDate!.month &&
              doc.data.year == _selectedDate!.year);
      return matchesSearch && matchesTipo && matchesDate;
    }).toList();

    return Scaffold(
      body: Column(
        children: [
          // Barra de pesquisa
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar documentos...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Filtros
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // Tipo do Documento (maior)
                Flexible(
                  flex: 3,
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    initialValue: _selectedTipo,
                    decoration: const InputDecoration(
                      labelText: 'Tipo de Documento',
                      border: OutlineInputBorder(),
                    ),
                    items: DocumentTypes.tiposDocumento
                        .map(
                          (tipo) => DropdownMenuItem(
                            value: tipo,
                            child: Text(
                              tipo,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedTipo = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                // Filtro por Data (menor)
                Flexible(
                  flex: 2,
                  child: InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          _selectedDate = picked;
                        });
                      }
                    },
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Data',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      child: Text(
                        _selectedDate == null
                            ? ''
                            : '${_selectedDate!.day.toString().padLeft(2, '0')}/'
                                  '${_selectedDate!.month.toString().padLeft(2, '0')}/'
                                  '${_selectedDate!.year}',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Lista de documentos
          Expanded(
            child: filteredDocs.isEmpty
                ? const Center(child: Text('Nenhum documento encontrado'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredDocs.length,
                    itemBuilder: (context, index) {
                      final doc = filteredDocs[index];
                      return DocumentCard(
                        documento: doc,
                        onTap: () {
                          // Aqui você pode abrir um detalhe do documento se quiser
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Abrir formulário e esperar o novo documento
          final novoDocumento = await Navigator.push<Document>(
            context,
            MaterialPageRoute(
              builder: (context) => const DocumentFormScreen(),
            ),
          );

          if (novoDocumento != null) {
            setState(() {
              DocumentData.addDocument(novoDocumento);
            });
          }
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
