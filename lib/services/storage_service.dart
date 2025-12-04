import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../data/document_data.dart';
import '../data/process_data.dart';
import '../models/document_model.dart';
import '../models/process_model.dart';

class StorageService {
  static const String _processesFileName = 'processes.json';
  static const String _documentsFileName = 'documents.json';

  /// Obter diretório de documentos da aplicação
  static Future<Directory> _getAppDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    final appDir = Directory('${directory.path}/advoguei_data');

    if (!await appDir.exists()) {
      await appDir.create(recursive: true);
    }

    return appDir;
  }

  /// Obter arquivo de processos
  static Future<File> _getProcessesFile() async {
    final dir = await _getAppDirectory();
    return File('${dir.path}/$_processesFileName');
  }

  /// Obter arquivo de documentos
  static Future<File> _getDocumentsFile() async {
    final dir = await _getAppDirectory();
    return File('${dir.path}/$_documentsFileName');
  }

  /// Salvar lista de processos
  static Future<void> saveProcesses(List<Process> processes) async {
    try {
      final file = await _getProcessesFile();
      final jsonList = processes.map((p) => _processToJson(p)).toList();
      final json = jsonEncode({'processes': jsonList});
      await file.writeAsString(json);
    } catch (e) {
      throw Exception('Erro ao salvar processos: $e');
    }
  }

  /// Carregar lista de processos
  static Future<List<Process>> loadProcesses() async {
    try {
      final file = await _getProcessesFile();

      if (!await file.exists()) {
        // Se o arquivo não existe, inicializamos com os dados iniciais marcados como globais
        final fixtures = ProcessData.getAllProcessos();
        final jsonList = fixtures
            .map(
              (p) => _processToJson(p.copyWith(ownerId: null, isGlobal: true)),
            )
            .toList();
        final json = jsonEncode({'processes': jsonList});
        await file.writeAsString(json);
        return fixtures
            .map((p) => p.copyWith(ownerId: null, isGlobal: true))
            .toList();
      }

      final contents = await file.readAsString();
      final json = jsonDecode(contents) as Map<String, dynamic>;
      final processesList = json['processes'] as List<dynamic>? ?? [];

      return processesList
          .map((p) => Process.fromJson(p as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // Se erro ao carregar, retorna dados iniciais marcados como globais
      return ProcessData.getAllProcessos()
          .map((p) => p.copyWith(ownerId: null, isGlobal: true))
          .toList();
    }
  }

  /// Salvar lista de documentos
  static Future<void> saveDocuments(List<Document> documents) async {
    try {
      final file = await _getDocumentsFile();
      final jsonList = documents.map((d) => _documentToJson(d)).toList();
      final json = jsonEncode({'documents': jsonList});
      await file.writeAsString(json);
    } catch (e) {
      throw Exception('Erro ao salvar documentos: $e');
    }
  }

  /// Carregar lista de documentos
  static Future<List<Document>> loadDocuments() async {
    try {
      final file = await _getDocumentsFile();

      if (!await file.exists()) {
        // Se o arquivo não existe, inicializamos com os dados iniciais marcados como globais
        final fixtures = DocumentData.getAllDocuments();
        final jsonList = fixtures
            .map(
              (d) => _documentToJson(d.copyWith(ownerId: null, isGlobal: true)),
            )
            .toList();
        final json = jsonEncode({'documents': jsonList});
        await file.writeAsString(json);
        return fixtures
            .map((d) => d.copyWith(ownerId: null, isGlobal: true))
            .toList();
      }

      final contents = await file.readAsString();
      final json = jsonDecode(contents) as Map<String, dynamic>;
      final documentsList = json['documents'] as List<dynamic>? ?? [];

      return documentsList
          .map((d) => Document.fromJson(d as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // Se erro ao carregar, retorna dados iniciais marcados como globais
      return DocumentData.getAllDocuments()
          .map((d) => d.copyWith(ownerId: null, isGlobal: true))
          .toList();
    }
  }

  /// Converter Process para JSON
  static Map<String, dynamic> _processToJson(Process process) {
    return {
      'id': process.id,
      'numero': process.numero,
      'cliente': process.cliente,
      'tipo': process.tipo,
      'status': process.status,
      'dataAbertura': process.dataAbertura.toIso8601String(),
      'cpfCnpjCliente': process.cpfCnpjCliente,
      'contatoCliente': process.contatoCliente,
      'descricao': process.descricao,
      'valorCausa': process.valorCausa,
      'comarca': process.comarca,
      'vara': process.vara,
      'nomeJuiz': process.nomeJuiz,
      'observacoes': process.observacoes,
      'ownerId': process.ownerId,
      'isGlobal': process.isGlobal,
    };
  }

  /// Converter Document para JSON
  static Map<String, dynamic> _documentToJson(Document document) {
    return {
      'id': document.id,
      'nome': document.nome,
      'tipo': document.tipo,
      'data': document.data.toIso8601String(),
      'clienteVinculado': document.clienteVinculado,
      'processoVinculado': document.processoVinculado,
      'observacao': document.observacao,
      'ownerId': document.ownerId,
      'isGlobal': document.isGlobal,
    };
  }
}
