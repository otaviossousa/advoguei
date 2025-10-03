import 'package:flutter/material.dart';

import '../models/process_model.dart';

class ProcessCard extends StatelessWidget {
  final Process processo;
  final VoidCallback onTap;

  const ProcessCard({
    super.key,
    required this.processo,
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
              // Status do processo
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(processo.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    processo.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Número do processo
              Text(
                processo.numero,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),

              // Informações do processo
              _buildInfoRow(
                icon: Icons.person,
                label: 'Cliente',
                value: processo.cliente,
              ),
              const SizedBox(height: 8),

              _buildInfoRow(
                icon: Icons.gavel,
                label: 'Tipo',
                value: processo.tipo,
              ),
              const SizedBox(height: 8),

              _buildInfoRow(
                icon: Icons.calendar_today,
                label: 'Data de Abertura',
                value: processo.dataAberturaFormatada,
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
        Icon(
          icon,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'em andamento':
        return Colors.blue;
      case 'aguardando sentença':
        return Colors.orange;
      case 'concluído':
        return Colors.green;
      case 'suspenso':
        return Colors.red;
      case 'arquivado':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
}
