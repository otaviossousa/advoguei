class Process {
  final String id;
  final String numero;
  final String cliente;
  final String tipo;
  final String status;
  final DateTime dataAbertura;
  final String? valorCausa;
  final String? descricao;
  final String? observacoes;

  const Process({
    required this.id,
    required this.numero,
    required this.cliente,
    required this.tipo,
    required this.status,
    required this.dataAbertura,
    this.valorCausa,
    this.descricao,
    this.observacoes,
  });

  // Construtor para criar um Process a partir de um Map
  factory Process.fromMap(Map<String, dynamic> map) {
    return Process(
      id: map['id'] ?? '',
      numero: map['numero'] ?? '',
      cliente: map['cliente'] ?? '',
      tipo: map['tipo'] ?? '',
      status: map['status'] ?? '',
      dataAbertura: map['dataAbertura'] is DateTime
          ? map['dataAbertura']
          : DateTime.tryParse(map['dataAbertura']) ?? DateTime.now(),
      valorCausa: map['valorCausa'],
      descricao: map['descricao'],
      observacoes: map['observacoes'],
    );
  }

  // Método para converter o Process para Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'numero': numero,
      'cliente': cliente,
      'tipo': tipo,
      'status': status,
      'dataAbertura': dataAbertura.toIso8601String(),
      'valorCausa': valorCausa,
      'descricao': descricao,
      'observacoes': observacoes,
    };
  }

  // Método para formatar a data de abertura
  String get dataAberturaFormatada {
    return '${dataAbertura.day.toString().padLeft(2, '0')}/'
        '${dataAbertura.month.toString().padLeft(2, '0')}/'
        '${dataAbertura.year}';
  }

  // Método para criar uma cópia com modificações
  Process copyWith({
    String? id,
    String? numero,
    String? cliente,
    String? tipo,
    String? status,
    DateTime? dataAbertura,
    String? valorCausa,
    String? descricao,
    String? observacoes,
  }) {
    return Process(
      id: id ?? this.id,
      numero: numero ?? this.numero,
      cliente: cliente ?? this.cliente,
      tipo: tipo ?? this.tipo,
      status: status ?? this.status,
      dataAbertura: dataAbertura ?? this.dataAbertura,
      valorCausa: valorCausa ?? this.valorCausa,
      descricao: descricao ?? this.descricao,
      observacoes: observacoes ?? this.observacoes,
    );
  }

  @override
  String toString() {
    return 'Process(id: $id, numero: $numero, cliente: $cliente, tipo: $tipo, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Process && other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
