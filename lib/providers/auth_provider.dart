import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';
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
        // restaurar filtros salvos do usuário
        await _ref.read(filterProvider.notifier).loadForUser(user.id);
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
      await _ref.read(filterProvider.notifier).loadForUser(id);
    }
  }

  Future<void> logout() async {
    // salvar filtros atuais deste usuário antes de deslogar
    final currentUser = state;
    if (currentUser != null) {
      await _ref.read(filterProvider.notifier).saveForUser(currentUser.id);
    }

    state = null;
    errorMessage = null;

    // remover credenciais persistidas
    final sp = await SharedPreferences.getInstance();
    await sp.remove('auth_id');
    await sp.remove('auth_email');
    await sp.remove('auth_name');

    // limpar filtros em memória após logout
    _ref.read(filterProvider.notifier).clear();
  }
}

// Riverpod para autenticação
final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier(ref);
});
