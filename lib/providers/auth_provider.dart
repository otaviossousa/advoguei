import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(null);

  String? errorMessage;

  Future<bool> login(String email, String password) async {
    try {
      final user = await AuthService.validateUser(email);

      if (user != null) {
        state = user;
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

  void logout() {
    state = null;
    errorMessage = null;
  }
}

// Riverpod para autenticação
final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});
