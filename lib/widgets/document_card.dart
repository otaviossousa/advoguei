import 'package:flutter/material.dart';

import '../models/document_model.dart';

class DocumentCard extends StatelessWidget {
  final Document documento;
  final VoidCallback onTap;

  const DocumentCard({
    super.key,
    required this.documento,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tipo do Documento
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getTipoColor(documento.tipo),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    documento.tipo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Nome do Documento
              Text(
                documento.nome,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),

              // Cliente vinculado
              if (documento.clienteVinculado != null)
                _buildInfoRow(
                  icon: Icons.person,
                  label: 'Cliente',
                  value: documento.clienteVinculado!,
                ),
              if (documento.clienteVinculado != null) const SizedBox(height: 8),

              // Data
              _buildInfoRow(
                icon: Icons.calendar_today,
                label: 'Data',
                value: documento.dataFormatada,
              ),
              const SizedBox(height: 8),

              // Processo vinculado
              if (documento.processoVinculado != null)
                _buildInfoRow(
                  icon: Icons.gavel,
                  label: 'Processo',
                  value: documento.processoVinculado!,
                ),
              if (documento.processoVinculado != null)
                const SizedBox(height: 8),

              // Observação
              if (documento.observacao != null &&
                  documento.observacao!.isNotEmpty)
                _buildInfoRow(
                  icon: Icons.note,
                  label: 'Observação',
                  value: documento.observacao!,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  Color _getTipoColor(String tipo) {
    switch (tipo.toLowerCase()) {
      case 'identificação':
        return Colors.blue;
      case 'contrato/acordo':
        return Colors.green;
      case 'procuração':
        return Colors.orange;
      case 'petição/manifestação':
        return Colors.purple;
      case 'decisão judicial/sentença':
        return Colors.red;
      case 'comprovante':
        return Colors.teal;
      case 'laudo/parecer':
        return Colors.brown;
      case 'outros':
      default:
        return Colors.grey;
    }
  }
}
