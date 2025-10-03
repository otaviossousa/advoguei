class Process {
  // Identificação do Processo
  final String id;
  final String numero;
  final String tipo;
  final String status;
  final DateTime dataAbertura;

  // Informações do Cliente
  final String cliente;
  final String? cpfCnpjCliente;
  final String? contatoCliente;

  // Detalhes do Processo
  final String? descricao;
  final String? valorCausa;
  final String? comarca;
  final String? vara;
  final String? nomeJuiz;

  // Observações
  final String? observacoes;

  const Process({
    required this.id,
    required this.numero,
    required this.cliente,
    required this.tipo,
    required this.status,
    required this.dataAbertura,
    this.cpfCnpjCliente,
    this.contatoCliente,
    this.descricao,
    this.valorCausa,
    this.comarca,
    this.vara,
    this.nomeJuiz,
    this.observacoes,
  });

  // Método para formatar a data de abertura
  String get dataAberturaFormatada {
    return '${dataAbertura.day.toString().padLeft(2, '0')}/'
        '${dataAbertura.month.toString().padLeft(2, '0')}/'
        '${dataAbertura.year}';
  }
}
