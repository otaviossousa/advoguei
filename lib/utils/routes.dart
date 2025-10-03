import 'package:flutter/material.dart';

import '../screens/initial_screen.dart';
import '../screens/process_form_screen.dart';
import '../screens/process_list_screen.dart';

class AppRoutes {
  static const String initialScreen = '/';
  static const String processListScreen = '/process-list';
  static const String processFormScreen = '/process-form';

  static Map<String, WidgetBuilder> routes = {
    initialScreen: (context) => const InitialScreen(),
    processListScreen: (context) => const ProcessListScreen(),
    processFormScreen: (context) => const ProcessFormScreen(),
  };
}
