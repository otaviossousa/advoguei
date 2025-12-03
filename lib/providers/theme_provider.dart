import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_provider.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final String? _userId;

  ThemeNotifier(this._userId) : super(ThemeMode.light) {
    _loadTheme();
  }

  bool get isDarkMode => state == ThemeMode.dark;

  void toggleTheme(bool isDark) async {
    state = isDark ? ThemeMode.dark : ThemeMode.light;

    final prefs = await SharedPreferences.getInstance();
    final key = _userId != null ? 'isDarkMode_$_userId' : 'isDarkMode';
    await prefs.setBool(key, isDark);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final key = _userId != null ? 'isDarkMode_$_userId' : 'isDarkMode';
    final isDark = prefs.getBool(key) ?? false;
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  final user = ref.watch(authProvider);
  return ThemeNotifier(user?.id);
});
