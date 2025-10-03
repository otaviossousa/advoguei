import 'package:flutter/material.dart';

import 'utils/routes.dart';
import 'utils/theme.dart';

void main() {
  runApp(const AdvogueApp());
}

class AdvogueApp extends StatelessWidget {
  const AdvogueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.mainScreen,
      routes: AppRoutes.routes,
    );
  }
}
