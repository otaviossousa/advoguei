class Document {
  // Identificação do Documento
  final String id;
  final String nome;
  final String tipo;
  final DateTime data;

  // Informações de Vinculação
  final List<String>? clienteVinculado;
  final List<String>? processoVinculado;

  // Detalhes Adicionais
  final String? observacao;

  // Cliente, processo e observação são opcionais
  const Document({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.data,
    this.clienteVinculado,
    this.processoVinculado,
    this.observacao,
  });

  // Método para formatar a data do documento
  String get dataFormatada {
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year}';
  }

  // Converter para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'tipo': tipo,
      'data': data.toIso8601String(),
      'clienteVinculado': clienteVinculado,
      'processoVinculado': processoVinculado,
      'observacao': observacao,
    };
  }

  // Criar a partir de JSON
  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'] as String,
      nome: json['nome'] as String,
      tipo: json['tipo'] as String,
      data: DateTime.parse(json['data'] as String),
      clienteVinculado: json['clienteVinculado'] != null
          ? List<String>.from(json['clienteVinculado'] as List<dynamic>)
          : null,
      processoVinculado: json['processoVinculado'] != null
          ? List<String>.from(json['processoVinculado'] as List<dynamic>)
          : null,
      observacao: json['observacao'] as String?,
    );
  }
}
