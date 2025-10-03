import '../models/process.dart';

class ProcessData {
  // processos para demonstração
  static final List<Process> _processos = [
    Process(
      id: '1',
      numero: '1001234-12.2023.8.26.0100',
      cliente: 'João Silva Santos',
      tipo: 'Ação Trabalhista',
      status: 'Em Andamento',
      dataAbertura: DateTime(2023, 3, 15),
      valorCausa: 'R\$ 25.000,00',
      descricao:
          'Ação trabalhista por rescisão indireta de contrato de trabalho',
    ),
    Process(
      id: '2',
      numero: '2001234-12.2023.8.26.0200',
      cliente: 'Maria Oliveira Lima',
      tipo: 'Ação Cível',
      status: 'Aguardando Sentença',
      dataAbertura: DateTime(2023, 2, 20),
      valorCausa: 'R\$ 15.000,00',
      descricao: 'Ação de cobrança por prestação de serviços',
    ),
    Process(
      id: '3',
      numero: '3001234-12.2023.8.26.0300',
      cliente: 'Pedro Costa Ferreira',
      tipo: 'Ação Criminal',
      status: 'Concluído',
      dataAbertura: DateTime(2023, 1, 10),
      descricao: 'Defesa em processo criminal por lesão corporal',
    ),
    Process(
      id: '4',
      numero: '4001234-12.2023.8.26.0400',
      cliente: 'Ana Carolina Souza',
      tipo: 'Ação de Família',
      status: 'Em Andamento',
      dataAbertura: DateTime(2023, 4, 5),
      valorCausa: 'R\$ 8.000,00',
      descricao: 'Ação de divórcio consensual com partilha de bens',
    ),
    Process(
      id: '5',
      numero: '5001234-12.2023.8.26.0500',
      cliente: 'Carlos Eduardo Lima',
      tipo: 'Ação Previdenciária',
      status: 'Suspenso',
      dataAbertura: DateTime(2023, 2, 12),
      valorCausa: 'R\$ 50.000,00',
      descricao: 'Revisão de benefício previdenciário por incapacidade',
    ),
  ];

  // Métodos para gerenciar os dados
  static List<Process> getAllProcessos() {
    return List.from(_processos);
  }

  static void addProcesso(Process processo) {
    _processos.add(processo);
  }

  static void removeProcesso(String numeroProcesso) {
    _processos.removeWhere((p) => p.numero == numeroProcesso);
  }

  static Process? getProcessoByNumero(String numero) {
    try {
      return _processos.firstWhere((p) => p.numero == numero);
    } catch (e) {
      return null;
    }
  }

  static Process? getProcessoById(String id) {
    try {
      return _processos.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<Process> getProcessosByStatus(String status) {
    return _processos.where((p) => p.status == status).toList();
  }

  static List<Process> getProcessosByCliente(String cliente) {
    return _processos
        .where((p) => p.cliente.toLowerCase().contains(cliente.toLowerCase()))
        .toList();
  }

  static int getTotalProcessos() {
    return _processos.length;
  }

  static int getProcessosCountByStatus(String status) {
    return _processos.where((p) => p.status == status).length;
  }
}
