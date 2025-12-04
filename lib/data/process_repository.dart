import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../models/process_model.dart';

class ProcessRepository {
  static const _fileName = 'processes.json';

  Future<File> _localFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  Future<List<Process>> loadAll() async {
    try {
      final file = await _localFile();
      if (!await file.exists()) {
        return [];
      }
      final contents = await file.readAsString();
      final List<dynamic> jsonList = json.decode(contents) as List<dynamic>;
      return jsonList
          .map((j) => Process.fromJson(j as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> saveAll(List<Process> list) async {
    final file = await _localFile();
    final jsonList = list.map((p) => p.toJson()).toList();
    await file.writeAsString(json.encode(jsonList));
  }
}
