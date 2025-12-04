import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/process_model.dart';
import '../providers/document_provider.dart';
import '../screens/document_detail_screen.dart';
import '../widgets/colored_badge.dart';

class ProcessDetailScreen extends ConsumerWidget {
  final Process processo;

  const ProcessDetailScreen({super.key, required this.processo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allDocs = ref.watch(documentProvider);
    final personalDocs = allDocs
        .where(
          (d) =>
              d.clienteVinculado != null &&
              d.clienteVinculado!.contains(processo.cliente),
        )
        .toList();
    final processDocs = allDocs
        .where(
          (d) =>
              d.processoVinculado != null &&
              d.processoVinculado!.contains(processo.numero),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Processo ${processo.numero}'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      processo.cliente,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    if ((processo.cpfCnpjCliente ?? '').isNotEmpty)
                      Row(
                        children: [
                          const Icon(Icons.badge, size: 16, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(
                            processo.cpfCnpjCliente ?? '-',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 6),
                    if ((processo.contatoCliente ?? '').isNotEmpty)
                      Row(
                        children: [
                          const Icon(Icons.phone, size: 16, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text(
                            processo.contatoCliente ?? '-',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Informações do Processo',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'SITUAÇÃO',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          ColoredBadge(
                            label: processo.status,
                            kind: BadgeKind.status,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildTwoColumn(
                        'Número',
                        processo.numero,
                        'Tipo',
                        processo.tipo,
                      ),
                      const SizedBox(height: 12),
                      _buildTwoColumn(
                        'Data de Abertura',
                        processo.dataAberturaFormatada,
                        'Valor',
                        processo.valorCausa ?? '-',
                      ),
                      const SizedBox(height: 12),
                      _buildTwoColumn(
                        'Comarca',
                        processo.comarca ?? '-',
                        'Vara',
                        processo.vara ?? '-',
                      ),
                      const SizedBox(height: 12),
                      _buildKeyValueColumn('Nome do Juiz', processo.nomeJuiz),
                      const SizedBox(height: 12),
                      _buildKeyValueColumn('Descrição', processo.descricao),
                      const SizedBox(height: 12),
                      _buildKeyValueColumn('Observações', processo.observacoes),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Documentos Pessoais',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      ...personalDocs.map(
                        (d) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.insert_drive_file,
                            color: Colors.blue,
                          ),
                          title: Text(d.nome),
                          subtitle: const Text('Anexado no cadastro'),
                          trailing: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        DocumentDetailScreen(documento: d),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.visibility,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    DocumentDetailScreen(documento: d),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Documentos do Processo',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 8),
                      ...processDocs.map(
                        (d) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(
                            Icons.description,
                            color: Colors.orange,
                          ),
                          title: Text(d.nome),
                          subtitle: const Text('Anexo do processo'),
                          trailing: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        DocumentDetailScreen(documento: d),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.visibility,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    DocumentDetailScreen(documento: d),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTwoColumn(
    String label1,
    String? value1,
    String label2,
    String? value2,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 520) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildKeyValueColumn(label1, value1),
              const SizedBox(height: 10),
              _buildKeyValueColumn(label2, value2),
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: _buildKeyValueColumn(label1, value1)),
            const SizedBox(width: 24),
            Expanded(child: _buildKeyValueColumn(label2, value2)),
          ],
        );
      },
    );
  }

  Widget _buildKeyValueColumn(String label, String? value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value ?? '-',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
