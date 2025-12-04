import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/document_model.dart';

class DocumentRepository {
  static const _fileName = 'documents.json';

  Future<File> _localFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  Future<List<Document>> loadAll() async {
    try {
      final file = await _localFile();
      if (!await file.exists()) {
        // return empty list if no file
        return [];
      }
      final contents = await file.readAsString();
      final List<dynamic> jsonList = json.decode(contents) as List<dynamic>;
      return jsonList
          .map((j) => Document.fromJson(j as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveAll(List<Document> docs) async {
    final file = await _localFile();
    final jsonList = docs.map((d) => d.toJson()).toList();
    await file.writeAsString(json.encode(jsonList));
  }
}
