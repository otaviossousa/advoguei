import 'package:flutter/material.dart';

class ProcessFormScreen extends StatelessWidget {
  const ProcessFormScreen({super.key});

  static const List<String> _tiposProcesso = [
    'Ação Cível',
    'Ação Trabalhista',
    'Ação Criminal',
    'Ação Previdenciária',
    'Ação de Família',
    'Ação Tributária',
    'Ação Administrativa',
    'Outro',
  ];

  static const List<String> _statusOptions = [
    'Em Andamento',
    'Aguardando Sentença',
    'Aguardando Recurso',
    'Concluído',
    'Suspenso',
    'Arquivado',
  ];

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
            _buildSectionTitle('Informações Básicas'),
            const SizedBox(height: 16),
            _buildTextFormField(
              label: 'Número do Processo *',
              hint: 'Ex: 1001234-12.2023.8.26.0100',
            ),
            const SizedBox(height: 16),
            _buildTextFormField(
              label: 'Nome do Cliente *',
              hint: 'Ex: João Silva Santos',
            ),
            const SizedBox(height: 16),
            _buildTextFormField(
              label: 'CPF/CNPJ do Cliente *',
              hint: 'Ex: 123.456.789-00',
            ),
            const SizedBox(height: 16),
            _buildDropdownField(
              label: 'Tipo de Processo *',
              value: 'Ação Cível',
              items: _tiposProcesso,
            ),
            const SizedBox(height: 16),
            _buildDropdownField(
              label: 'Status *',
              value: 'Em Andamento',
              items: _statusOptions,
            ),
            const SizedBox(height: 16),
            _buildDateField(context, 'Data de Abertura *'),

            const SizedBox(height: 32),

            // Seção 2: Detalhes do Processo
            _buildSectionTitle('Detalhes do Processo'),
            const SizedBox(height: 16),
            _buildTextFormField(
              label: 'Descrição do Processo *',
              hint: 'Descreva brevemente o objeto da ação...',
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            _buildTextFormField(
              label: 'Valor da Causa',
              hint: 'Ex: R\$ 15.000,00',
            ),
            const SizedBox(height: 16),
            _buildTextFormField(
              label: 'Comarca/Foro',
              hint: 'Ex: Foro Central - Parnaíba',
            ),
            const SizedBox(height: 16),
            _buildTextFormField(
              label: 'Vara/Juízo',
              hint: 'Ex: 1ª Vara Cível',
            ),
            const SizedBox(height: 16),
            _buildTextFormField(
              label: 'Nome do Juiz',
              hint: 'Ex: Dr. Marcel Moura',
            ),

            const SizedBox(height: 32),

            // Seção 3: Documentos
            _buildSectionTitle('Documentos'),
            const SizedBox(height: 16),

            // Documentos do Cliente
            _buildSubSectionTitle('Documentos do Cliente'),
            const SizedBox(height: 12),
            _buildDocumentCard(
              title: 'RG do Cliente',
              description: 'Documento de identidade',
              icon: Icons.badge,
              onTap: () => _showDocumentDialog(context, 'RG do Cliente'),
            ),
            const SizedBox(height: 8),
            _buildDocumentCard(
              title: 'CPF do Cliente',
              description: 'Cadastro de Pessoa Física',
              icon: Icons.assignment_ind,
              onTap: () => _showDocumentDialog(context, 'CPF do Cliente'),
            ),
            const SizedBox(height: 8),
            _buildDocumentCard(
              title: 'Comprovante de Residência',
              description: 'Documento atualizado (últimos 3 meses)',
              icon: Icons.home,
              onTap: () =>
                  _showDocumentDialog(context, 'Comprovante de Residência'),
            ),

            const SizedBox(height: 24),

            // Documentos do Processo
            _buildSubSectionTitle('Documentos do Processo'),
            const SizedBox(height: 12),
            _buildDocumentCard(
              title: 'Petição Inicial',
              description: 'Documento principal da ação',
              icon: Icons.description,
              onTap: () => _showDocumentDialog(context, 'Petição Inicial'),
            ),
            const SizedBox(height: 8),
            _buildDocumentCard(
              title: 'Procuração',
              description: 'Documento de representação legal',
              icon: Icons.how_to_reg,
              onTap: () => _showDocumentDialog(context, 'Procuração'),
            ),
            const SizedBox(height: 8),
            _buildDocumentCard(
              title: 'Contratos/Documentos Base',
              description: 'Documentos que fundamentam a ação',
              icon: Icons.folder_open,
              onTap: () =>
                  _showDocumentDialog(context, 'Contratos/Documentos Base'),
            ),
            const SizedBox(height: 8),
            _buildDocumentCard(
              title: 'Outros Documentos',
              description: 'Documentos complementares',
              icon: Icons.attach_file,
              onTap: () => _showDocumentDialog(context, 'Outros Documentos'),
            ),

            const SizedBox(height: 32),

            // Seção 4: Observações
            _buildSectionTitle('Observações'),
            const SizedBox(height: 16),
            _buildTextFormField(
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1565C0),
      ),
    );
  }

  Widget _buildSubSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF424242),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    String? hint,
    int maxLines = 1,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      maxLines: maxLines,
      readOnly: true,
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (value) => true,
    );
  }

  Widget _buildDateField(BuildContext context, String label) {
    final now = DateTime.now();
    final formattedDate =
        '${now.day.toString().padLeft(2, '0')}/'
        '${now.month.toString().padLeft(2, '0')}/${now.year}';

    return InkWell(
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(formattedDate),
      ),
    );
  }

  Widget _buildDocumentCard({
    required String title,
    required String description,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF1565C0),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: const Icon(Icons.add_circle_outline),
        onTap: onTap,
      ),
    );
  }

  void _showDocumentDialog(BuildContext context, String documentType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Anexar $documentType'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tirar Foto'),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeria'),
              ),
              ListTile(
                leading: const Icon(Icons.folder),
                title: const Text('Arquivos'),
              ),
            ],
          ),
        );
      },
    );
  }
}
