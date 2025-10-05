import '../models/process_model.dart';

class ProcessData {
  // processos para demonstração
  static final List<Process> _processos = [
    Process(
      id: '1',
      numero: '1001234-12.2023.8.26.0100',
      cliente: 'Otávio Bruno Sousa Martins',
      cpfCnpjCliente: '123.456.789-00',
      contatoCliente: '(86) 99988-7766',
      tipo: 'Ação Trabalhista',
      status: 'Em Andamento',
      dataAbertura: DateTime(2023, 3, 15),
      valorCausa: 'R\$ 25.000,00',
      descricao:
          'Ação trabalhista por rescisão indireta de contrato de trabalho',
      comarca: 'Foro Trabalhista - Parnaíba',
      vara: '1ª Vara do Trabalho',
      nomeJuiz: 'Dr. João Carlos Silva',
      observacoes: 'Cliente trabalhou por 5 anos na empresa',
    ),
    Process(
      id: '2',
      numero: '2001234-12.2023.8.26.0200',
      cliente: 'Elinne Pacheco',
      cpfCnpjCliente: '987.654.321-00',
      contatoCliente: '(86) 98877-6655',
      tipo: 'Ação Cível',
      status: 'Aguardando Sentença',
      dataAbertura: DateTime(2023, 2, 20),
      valorCausa: 'R\$ 15.000,00',
      descricao: 'Ação de cobrança por prestação de serviços',
      comarca: 'Foro Central - Parnaíba',
      vara: '2ª Vara Cível',
      nomeJuiz: 'Dra. Maria Santos',
      observacoes: 'Serviços de consultoria prestados em 2022',
    ),
    Process(
      id: '3',
      numero: '3001234-12.2023.8.26.0300',
      cliente: 'Fernanda Oliveira de Farias',
      cpfCnpjCliente: '456.789.123-00',
      contatoCliente: '(86) 97766-5544',
      tipo: 'Ação Criminal',
      status: 'Concluído',
      dataAbertura: DateTime(2023, 1, 10),
      descricao: 'Defesa em processo criminal por lesão corporal',
      comarca: 'Foro Criminal - Parnaíba',
      vara: '1ª Vara Criminal',
      nomeJuiz: 'Dr. Pedro Moura',
      observacoes: 'Absolvição por legítima defesa',
    ),
    Process(
      id: '4',
      numero: '4001234-12.2023.8.26.0400',
      cliente: 'Cauã Wesly',
      cpfCnpjCliente: '321.654.987-00',
      contatoCliente: '(86) 96655-4433',
      tipo: 'Ação de Família',
      status: 'Em Andamento',
      dataAbertura: DateTime(2023, 4, 5),
      valorCausa: 'R\$ 8.000,00',
      descricao: 'Ação de divórcio consensual com partilha de bens',
      comarca: 'Foro de Família - Parnaíba',
      vara: 'Vara de Família e Sucessões',
      nomeJuiz: 'Dra. Ana Paula Costa',
      observacoes: 'Casal tem um filho menor de idade',
    ),
    Process(
      id: '5',
      numero: '5001234-12.2023.8.26.0500',
      cliente: 'Francisco Gerson de Menezes',
      cpfCnpjCliente: '789.123.456-00',
      contatoCliente: '(86) 95544-3322',
      tipo: 'Ação Previdenciária',
      status: 'Suspenso',
      dataAbertura: DateTime(2023, 2, 12),
      valorCausa: 'R\$ 50.000,00',
      descricao: 'Revisão de benefício previdenciário por incapacidade',
      comarca: 'Juizado Especial Federal - Parnaíba',
      vara: '1ª Vara Federal',
      nomeJuiz: 'Dr. Roberto Farias',
      observacoes: 'Aguardando perícia médica do INSS',
    ),
  ];

  // Método para obter todos os processos
  static List<Process> getAllProcessos() {
    return List.from(_processos);
  }
}
