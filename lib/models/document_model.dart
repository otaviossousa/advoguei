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
}
