import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/user_model.dart';

class AuthService {
  static List<User>? _authorizedUsers;

  static Future<List<User>> _loadAuthorizedUsers() async {
    if (_authorizedUsers != null) return _authorizedUsers!;

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/authorized_users.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> usersJson = jsonData['users'];

      _authorizedUsers = usersJson
          .map((userJson) => User.fromJson(userJson))
          .toList();
      return _authorizedUsers!;
    } catch (e) {
      return [];
    }
  }

  static Future<User?> validateUser(String email) async {
    final users = await _loadAuthorizedUsers();

    try {
      return users.firstWhere(
        (user) => user.email.toLowerCase() == email.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  static Future<bool> isUserAuthorized(String email) async {
    final user = await validateUser(email);
    return user != null;
  }
}
