import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/user_model.dart';
import 'providers/auth_provider.dart';
import 'providers/document_provider.dart';
import 'providers/process_provider.dart';
import 'providers/theme_provider.dart';
import 'utils/routes.dart';
import 'utils/theme.dart';

void main() {
  runApp(
    const ProviderScope(
      child: AdvogueApp(),
    ),
  );
}

class AdvogueApp extends ConsumerWidget {
  const AdvogueApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    // Quando o usuário faz login, carregamos os documentos e processos visíveis
    ref.listen<User?>(authProvider, (previous, next) {
      if (next != null) {
        // carregar itens visíveis para o usuário
        ref.read(documentProvider.notifier).loadForUser(next.id);
        ref.read(processProvider.notifier).loadForUser(next.id);
      } else {
        // usuário deslogado — carregar apenas itens globais
        ref.read(documentProvider.notifier).loadForUser(null);
        ref.read(processProvider.notifier).loadForUser(null);
      }
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advoguei',
      themeMode: themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: AppRoutes.loginScreen,
      routes: AppRoutes.routes,
    );
  }
}
