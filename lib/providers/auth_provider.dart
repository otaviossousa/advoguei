import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';
import 'dart:convert';

import 'filter_provider.dart';

class AuthNotifier extends StateNotifier<User?> {
  final Ref _ref;

  AuthNotifier(this._ref) : super(null) {
    _loadFromPrefs();
  }

  String? errorMessage;

  Future<bool> login(String email, String password) async {
    try {
      final user = await AuthService.validateUser(email);

      if (user != null) {
        state = user;
        // persistir usuário
        final sp = await SharedPreferences.getInstance();
        await sp.setString('auth_id', user.id);
        await sp.setString('auth_email', user.email);
        await sp.setString('auth_name', user.name);
        errorMessage = null;
        // restaurar filtros salvos para este usuário (após login explícito)
        await _restoreFiltersForUser(user.id);
        return true;
      } else {
        errorMessage = 'Acesso não autorizado';
        return false;
      }
    } catch (e) {
      errorMessage = 'Erro ao fazer login. Tente novamente.';
      return false;
    }
  }

  Future<void> _loadFromPrefs() async {
    final sp = await SharedPreferences.getInstance();
    final id = sp.getString('auth_id');
    final email = sp.getString('auth_email');
    final name = sp.getString('auth_name');
    if (id != null && email != null && name != null) {
      state = User(id: id, email: email, name: name);
    }
  }

  void logout() {
    // salvar filtros atuais deste usuário antes de deslogar
    final currentUser = state;
    if (currentUser != null) {
      _saveFiltersForUser(currentUser.id);
    }

    state = null;
    errorMessage = null;

    // remover credenciais persistidas
    SharedPreferences.getInstance().then((sp) async {
      await sp.remove('auth_id');
      await sp.remove('auth_email');
      await sp.remove('auth_name');
    });

    // limpar filtros em memória após logout
    _ref.read(filterProvider.notifier).clear();
  }

  Future<void> _saveFiltersForUser(String userId) async {
    final sp = await SharedPreferences.getInstance();
    final filters = _ref.read(filterProvider);
    final jsonString = json.encode(filters.toJson());
    await sp.setString('saved_filters_$userId', jsonString);
  }

  Future<void> _restoreFiltersForUser(String userId) async {
    final sp = await SharedPreferences.getInstance();
    final jsonString = sp.getString('saved_filters_$userId');
    if (jsonString == null) return;
    try {
      final Map<String, dynamic> data = json.decode(jsonString);
      final restored = FilterState.fromJson(data);
      // aplicar filtros restaurados no provider
      final notifier = _ref.read(filterProvider.notifier);
      notifier.setDocumentQuery(restored.documentQuery);
      notifier.setProcessQuery(restored.processQuery);
    } catch (e) {
      // ignorar erros ao restaurar filtros
    }
  }
}

// Riverpod para autenticação
final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier(ref);
});
