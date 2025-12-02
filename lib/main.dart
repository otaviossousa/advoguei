import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'utils/routes.dart';
import 'utils/theme.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const AdvogueApp(),
    ),
  );
}

class AdvogueApp extends StatelessWidget {
  const AdvogueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Advoguei',

          themeMode: themeProvider.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,

          initialRoute: AppRoutes.mainScreen,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
