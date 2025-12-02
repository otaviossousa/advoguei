import 'package:flutter/material.dart';

Color statusColor(String status) {
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

Color documentTypeColor(String tipo) {
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
