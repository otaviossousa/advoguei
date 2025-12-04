import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class CurrentUserNotifier extends StateNotifier<User?> {
  CurrentUserNotifier() : super(null);

  Future<void> loadFromPrefs() async {
    final sp = await SharedPreferences.getInstance();
    final id = sp.getString('currentUserId');
    final email = sp.getString('currentUserEmail');
    final name = sp.getString('currentUserName');
    if (id != null && email != null && name != null) {
      state = User(id: id, email: email, name: name);
    }
  }

  Future<void> setUser(User user) async {
    state = user;
    final sp = await SharedPreferences.getInstance();
    await sp.setString('currentUserId', user.id);
    await sp.setString('currentUserEmail', user.email);
    await sp.setString('currentUserName', user.name);
  }

  Future<void> clear() async {
    state = null;
    final sp = await SharedPreferences.getInstance();
    await sp.remove('currentUserId');
    await sp.remove('currentUserEmail');
    await sp.remove('currentUserName');
  }
}

final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, User?>((
  ref,
) {
  final notifier = CurrentUserNotifier();
  notifier.loadFromPrefs();
  return notifier;
});
