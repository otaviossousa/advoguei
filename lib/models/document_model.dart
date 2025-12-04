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

  // Propriedade de ownership para controle por usuário
  final String? ownerId;
  final bool isGlobal;

  // Cliente, processo e observação são opcionais
  const Document({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.data,
    this.clienteVinculado,
    this.processoVinculado,
    this.observacao,
    this.ownerId,
    this.isGlobal = false,
  });

  // Método para formatar a data do documento
  String get dataFormatada {
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year}';
  }

  // Criar uma cópia com campos modificados
  Document copyWith({
    String? id,
    String? nome,
    String? tipo,
    DateTime? data,
    List<String>? clienteVinculado,
    List<String>? processoVinculado,
    String? observacao,
    String? ownerId,
    bool? isGlobal,
  }) {
    return Document(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      tipo: tipo ?? this.tipo,
      data: data ?? this.data,
      clienteVinculado: clienteVinculado ?? this.clienteVinculado,
      processoVinculado: processoVinculado ?? this.processoVinculado,
      observacao: observacao ?? this.observacao,
      ownerId: ownerId ?? this.ownerId,
      isGlobal: isGlobal ?? this.isGlobal,
    );
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
      'ownerId': ownerId,
      'isGlobal': isGlobal,
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
      ownerId: json['ownerId'] as String?,
      isGlobal: json['isGlobal'] == null ? false : json['isGlobal'] as bool,
    );
  }
}
