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

  // CPF/CNPJ, contato, descrição, valor da causa, comarca, vara, nome do juiz e observações são opcionais
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

  // Converter para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numero': numero,
      'cliente': cliente,
      'tipo': tipo,
      'status': status,
      'dataAbertura': dataAbertura.toIso8601String(),
      'cpfCnpjCliente': cpfCnpjCliente,
      'contatoCliente': contatoCliente,
      'descricao': descricao,
      'valorCausa': valorCausa,
      'comarca': comarca,
      'vara': vara,
      'nomeJuiz': nomeJuiz,
      'observacoes': observacoes,
    };
  }

  // Criar a partir de JSON
  factory Process.fromJson(Map<String, dynamic> json) {
    return Process(
      id: json['id'] as String,
      numero: json['numero'] as String,
      cliente: json['cliente'] as String,
      tipo: json['tipo'] as String,
      status: json['status'] as String,
      dataAbertura: DateTime.parse(json['dataAbertura'] as String),
      cpfCnpjCliente: json['cpfCnpjCliente'] as String?,
      contatoCliente: json['contatoCliente'] as String?,
      descricao: json['descricao'] as String?,
      valorCausa: json['valorCausa'] as String?,
      comarca: json['comarca'] as String?,
      vara: json['vara'] as String?,
      nomeJuiz: json['nomeJuiz'] as String?,
      observacoes: json['observacoes'] as String?,
    );
  }
}
