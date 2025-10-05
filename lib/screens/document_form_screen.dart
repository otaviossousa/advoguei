import 'package:flutter/material.dart';

import '../data/constants.dart';
import '../widgets/form_widgets.dart';

class DocumentFormScreen extends StatelessWidget {
  const DocumentFormScreen({super.key});

  // Simulação de clientes/processos cadastrados
  static const List<String> _clientes = [
    'Nenhum',
    'João Silva',
    'Maria Oliveira',
    'Carlos Souza',
  ];

  static const List<String> _processos = [
    'Nenhum',
    '1001234-12.2023.8.26.0100',
    '1005678-34.2023.8.26.0100',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Documento')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Anexar Documento
            const SectionTitle(title: 'Anexar Documento'),
            const SizedBox(height: 16),
            CustomDocumentCard(
              title: 'Selecionar Arquivo',
              description: 'Escolha a origem do documento',
              icon: Icons.attach_file,
              onTap: () => DocumentSelectionDialog.show(context, 'Documento'),
            ),
            const SizedBox(height: 24),

            // Informações do Documento
            const SectionTitle(title: 'Informações do Documento'),
            const SizedBox(height: 16),
            const CustomTextFormField(
              label: 'Nome do Documento',
              hint: 'Ex: RG João Silva',
            ),
            const SizedBox(height: 16),
            const CustomDropdownField(
              label: 'Tipo de Documento',
              value: 'Identificação',
              items: DocumentTypes.tiposDocumento,
            ),
            const SizedBox(height: 16),
            const CustomDropdownField(
              label: 'Vincular Cliente',
              value: 'Nenhum',
              items: _clientes,
            ),
            const SizedBox(height: 16),
            const CustomDropdownField(
              label: 'Vincular Processo',
              value: 'Nenhum',
              items: _processos,
            ),
            const SizedBox(height: 16),
            const CustomTextFormField(
              label: 'Observações',
              hint: 'Ex: Documento digitalizado em alta qualidade',
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // Botão Adicionar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                },
                child: const Text('Adicionar Documento'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
