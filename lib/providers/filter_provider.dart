import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterState {
  final String documentQuery;
  final String processQuery;

  const FilterState({this.documentQuery = '', this.processQuery = ''});

  FilterState copyWith({String? documentQuery, String? processQuery}) {
    return FilterState(
      documentQuery: documentQuery ?? this.documentQuery,
      processQuery: processQuery ?? this.processQuery,
    );
  }

  Map<String, dynamic> toJson() => {
    'documentQuery': documentQuery,
    'processQuery': processQuery,
  };

  factory FilterState.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const FilterState();
    return FilterState(
      documentQuery: json['documentQuery'] as String? ?? '',
      processQuery: json['processQuery'] as String? ?? '',
    );
  }
}

class FilterNotifier extends StateNotifier<FilterState> {
  FilterNotifier() : super(const FilterState());

  void setDocumentQuery(String q) {
    state = state.copyWith(documentQuery: q);
  }

  void setProcessQuery(String q) {
    state = state.copyWith(processQuery: q);
  }

  void clear() {
    state = const FilterState();
  }

  Future<void> saveForUser(String userId) async {
    final sp = await SharedPreferences.getInstance();
    final jsonString = json.encode(state.toJson());
    await sp.setString('saved_filters_$userId', jsonString);
  }

  Future<void> loadForUser(String userId) async {
    final sp = await SharedPreferences.getInstance();
    final jsonString = sp.getString('saved_filters_$userId');
    if (jsonString == null) return;
    try {
      final Map<String, dynamic> data = json.decode(jsonString);
      final restored = FilterState.fromJson(data);
      state = restored;
    } catch (e) {
      // ignorar erro
    }
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, FilterState>((
  ref,
) {
  return FilterNotifier();
});
