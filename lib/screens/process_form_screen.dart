import 'package:flutter/material.dart';

import '../data/constants.dart';
import '../widgets/form_widgets.dart';

class ProcessFormScreen extends StatelessWidget {
  const ProcessFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Processo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seção 1: Informações Básicas
            const SectionTitle(title: 'Informações Básicas'),
            const SizedBox(height: 16),
            const CustomTextFormField(
              label: 'Número do Processo *',
              hint: 'Ex: 1001234-12.2023.8.26.0100',
            ),
            const SizedBox(height: 16),
            const CustomTextFormField(
              label: 'Nome do Cliente *',
              hint: 'Ex: João Silva Santos',
            ),
            const SizedBox(height: 16),
            const CustomTextFormField(
              label: 'CPF/CNPJ do Cliente *',
              hint: 'Ex: 123.456.789-00',
            ),
            const SizedBox(height: 16),
            const CustomDropdownField(
              label: 'Tipo de Processo *',
              value: 'Ação Cível',
              items: ProcessTypes.tiposProcesso,
            ),
            const SizedBox(height: 16),
            const CustomDropdownField(
              label: 'Status *',
              value: 'Em Andamento',
              items: ProcessTypes.statusOptions,
            ),
            const SizedBox(height: 16),
            const CustomDateField(label: 'Data de Abertura *'),

            const SizedBox(height: 32),

            // Seção 2: Detalhes do Processo
            const SectionTitle(title: 'Detalhes do Processo'),
            const SizedBox(height: 16),
            const CustomTextFormField(
              label: 'Descrição do Processo *',
              hint: 'Descreva brevemente o objeto da ação...',
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            const CustomTextFormField(
              label: 'Valor da Causa',
              hint: 'Ex: R\$ 15.000,00',
            ),
            const SizedBox(height: 16),
            const CustomTextFormField(
              label: 'Comarca/Foro',
              hint: 'Ex: Foro Central - Parnaíba',
            ),
            const SizedBox(height: 16),
            const CustomTextFormField(
              label: 'Vara/Juízo',
              hint: 'Ex: 1ª Vara Cível',
            ),
            const SizedBox(height: 16),
            const CustomTextFormField(
              label: 'Nome do Juiz',
              hint: 'Ex: Dr. Marcel Moura',
            ),

            const SizedBox(height: 32),

            // Seção 3: Documentos
            const SectionTitle(title: 'Documentos'),
            const SizedBox(height: 16),

            // Documentos do Cliente
            const SubSectionTitle(title: 'Documentos do Cliente'),
            const SizedBox(height: 12),
            CustomDocumentCard(
              title: 'RG do Cliente',
              description: 'Documento de identidade',
              icon: Icons.badge,
              onTap: () =>
                  DocumentSelectionDialog.show(context, 'RG do Cliente'),
            ),
            const SizedBox(height: 8),
            CustomDocumentCard(
              title: 'CPF do Cliente',
              description: 'Cadastro de Pessoa Física',
              icon: Icons.assignment_ind,
              onTap: () =>
                  DocumentSelectionDialog.show(context, 'CPF do Cliente'),
            ),
            const SizedBox(height: 8),
            CustomDocumentCard(
              title: 'Comprovante de Residência',
              description: 'Documento atualizado (últimos 3 meses)',
              icon: Icons.home,
              onTap: () => DocumentSelectionDialog.show(
                context,
                'Comprovante de Residência',
              ),
            ),

            const SizedBox(height: 24),

            // Documentos do Processo
            const SubSectionTitle(title: 'Documentos do Processo'),
            const SizedBox(height: 12),
            CustomDocumentCard(
              title: 'Petição Inicial',
              description: 'Documento principal da ação',
              icon: Icons.description,
              onTap: () =>
                  DocumentSelectionDialog.show(context, 'Petição Inicial'),
            ),
            const SizedBox(height: 8),
            CustomDocumentCard(
              title: 'Procuração',
              description: 'Documento de representação legal',
              icon: Icons.how_to_reg,
              onTap: () => DocumentSelectionDialog.show(context, 'Procuração'),
            ),
            const SizedBox(height: 8),
            CustomDocumentCard(
              title: 'Contratos/Documentos Base',
              description: 'Documentos que fundamentam a ação',
              icon: Icons.folder_open,
              onTap: () => DocumentSelectionDialog.show(
                context,
                'Contratos/Documentos Base',
              ),
            ),
            const SizedBox(height: 8),
            CustomDocumentCard(
              title: 'Outros Documentos',
              description: 'Documentos complementares',
              icon: Icons.attach_file,
              onTap: () =>
                  DocumentSelectionDialog.show(context, 'Outros Documentos'),
            ),

            const SizedBox(height: 32),

            // Seção 4: Observações
            const SectionTitle(title: 'Observações'),
            const SizedBox(height: 16),
            const CustomTextFormField(
              label: 'Observações Gerais',
              hint: 'Observações adicionais sobre o processo...',
              maxLines: 4,
            ),

            const SizedBox(height: 32),

            // Botão de Salvar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Cadastrar Processo',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
