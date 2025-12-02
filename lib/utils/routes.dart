import 'package:flutter/material.dart';

import '../models/process_model.dart';
import '../screens/about_members_screen.dart';
import '../screens/document_list_screen.dart';
import '../screens/main_screen.dart';
import '../screens/process_detail_screen.dart';
import '../screens/process_form_screen.dart';
import '../screens/process_list_screen.dart';

class AppRoutes {
  static const String mainScreen = '/';
  static const String processListScreen = '/process-list';
  static const String processFormScreen = '/process-form';
  static const String processDetailScreen = '/process-detail';
  static const String documentListScreen = '/document-list';
  static const String aboutScreen = '/about';

  static Map<String, WidgetBuilder> routes = {
    mainScreen: (context) => const MainScreen(),
    processListScreen: (context) => const ProcessListScreen(),
    processFormScreen: (context) => const ProcessFormScreen(),
    processDetailScreen: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Process;
      return ProcessDetailScreen(processo: args);
    },
    documentListScreen: (context) => const DocumentListScreen(),
    aboutScreen: (context) => const AboutMembersScreen(),
  };
}
