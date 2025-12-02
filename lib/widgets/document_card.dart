import 'package:flutter/material.dart';

import '../models/document_model.dart';
import 'colored_badge.dart';

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
              Align(
                alignment: Alignment.centerLeft,
                child: ColoredBadge(
                  label: documento.tipo,
                  kind: BadgeKind.documentType,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                documento.nome,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),

              if (documento.clienteVinculado != null &&
                  documento.clienteVinculado!.isNotEmpty)
                _buildInfoRow(
                  icon: Icons.person,
                  label: 'Cliente',
                  value: documento.clienteVinculado!.join(', '),
                ),
              if (documento.clienteVinculado != null &&
                  documento.clienteVinculado!.isNotEmpty)
                const SizedBox(height: 8),

              _buildInfoRow(
                icon: Icons.calendar_today,
                label: 'Data',
                value: documento.dataFormatada,
              ),
              const SizedBox(height: 8),

              if (documento.processoVinculado != null &&
                  documento.processoVinculado!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: documento.processoVinculado!.map((procNumero) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: _buildInfoRow(
                        icon: Icons.gavel,
                        label: 'Processo',
                        value: procNumero,
                      ),
                    );
                  }).toList(),
                ),
              if (documento.processoVinculado != null &&
                  documento.processoVinculado!.isNotEmpty)
                const SizedBox(height: 8),

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
}
