import 'package:flutter/material.dart';
// import '../services/auth_service.dart'; // Comentado temporariamente - service não existe ainda

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = true;
  String? _currentUser;
  String? _errorMessage;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get currentUser => _currentUser;
  String? get errorMessage => _errorMessage;

  AuthProvider() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      // _isAuthenticated = await AuthService.instance.isLoggedIn();
      // if (_isAuthenticated) {
      //   _currentUser = await AuthService.instance.getCurrentUser();
      // }
      _isAuthenticated = false; // Temporário - sempre não autenticado
      _currentUser = null;
    } catch (e) {
      _isAuthenticated = false;
      _currentUser = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _errorMessage = null;
    notifyListeners();

    try {
      // final success = await AuthService.instance.login(email, password);
      final success = true; // Temporário - sempre sucesso

      if (success) {
        _isAuthenticated = true;
        _currentUser = email;
        _errorMessage = null;
      }
      // else {
      //   _errorMessage = 'Email ou senha incorretos';
      // }

      notifyListeners();
      return success;
    } catch (e) {
      _errorMessage = 'Erro ao fazer login. Tente novamente.';
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    try {
      // await AuthService.instance.logout();
      _isAuthenticated = false;
      _currentUser = null;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erro ao fazer logout';
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
