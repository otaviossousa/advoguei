import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(null) {
    _loadFromPrefs();
  }

  String? errorMessage;

  Future<bool> login(String email, String password) async {
    try {
      final user = await AuthService.validateUser(email);

      if (user != null) {
        state = user;
        // persist user
        final sp = await SharedPreferences.getInstance();
        await sp.setString('auth_id', user.id);
        await sp.setString('auth_email', user.email);
        await sp.setString('auth_name', user.name);
        errorMessage = null;
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
    state = null;
    errorMessage = null;
    SharedPreferences.getInstance().then((sp) async {
      await sp.remove('auth_id');
      await sp.remove('auth_email');
      await sp.remove('auth_name');
    });
  }
}

// Riverpod para autenticação
final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});
