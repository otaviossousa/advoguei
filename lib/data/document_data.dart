import '../models/document_model.dart';

class DocumentData {
  // Lista estática de documentos para demonstração (dados iniciais)
  static final List<Document> _documents = [
    Document(
      id: '1',
      nome: 'RG Marcel Moura',
      tipo: 'Identificação',
      data: DateTime(2023, 5, 10),
      clienteVinculado: ['Marcel Moura'],
      processoVinculado: ['1001234-12.2023.8.26.0100'],
    ),
    Document(
      id: '2',
      nome: 'Contrato de Prestação de Serviços',
      tipo: 'Contrato/Acordo',
      data: DateTime(2023, 7, 5),
      processoVinculado: ['1001234-12.2023.8.26.0100'],
    ),
    Document(
      id: '3',
      nome: 'Petição Inicial',
      tipo: 'Petição/Manifestação',
      data: DateTime(2023, 6, 1),
      clienteVinculado: ['Francisco Gerson Meneses'],
      processoVinculado: ['1005678-34.2023.8.26.0100'],
      observacao: 'Documento principal da ação',
    ),
    Document(
      id: '4',
      nome: 'Procuração',
      tipo: 'Procuração',
      data: DateTime(2023, 5, 15),
      clienteVinculado: ['Ex do Cauã'],
      processoVinculado: ['1001234-12.2023.8.26.0100'],
      observacao: 'Documento de representação legal',
    ),
    Document(
      id: '5',
      nome: 'Modelo de Petição',
      tipo: 'Petição/Manifestação',
      data: DateTime(2023, 8, 12),
      observacao: 'Documento modelo para futuras ações',
    ),
    Document(
      id: '6',
      nome: 'Certidão de Nascimento',
      tipo: 'Identificação',
      data: DateTime(2023, 9, 3),
      clienteVinculado: ['Cauê Wesly'],
      observacao: 'Filho do Cauã',
    ),
  ];

  static List<Document> getAllDocuments() {
    return List.from(_documents);
  }
}
