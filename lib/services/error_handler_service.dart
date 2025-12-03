import 'package:flutter/material.dart';

import '../utils/process_number_validator.dart';

class ErrorHandlerService {
  /// Exibe um SnackBar de erro
  static void showErrorSnackBar(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: duration,
      ),
    );
  }

  /// Exibe um SnackBar de sucesso
  static void showSuccessSnackBar(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: duration,
      ),
    );
  }

  /// Valida campo de texto obrigatório
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'O campo $fieldName é obrigatório';
    }
    return null;
  }

  /// Valida um número (CPF/CNPJ)
  static String? validateNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'O campo $fieldName é obrigatório';
    }

    final numOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (numOnly.isEmpty) {
      return 'O campo $fieldName deve conter apenas números';
    }

    return null;
  }

  /// Valida um campo com comprimento mínimo
  static String? validateMinLength(
    String? value,
    String fieldName,
    int minLength,
  ) {
    if (value == null || value.isEmpty) {
      return 'O campo $fieldName é obrigatório';
    }

    if (value.length < minLength) {
      return 'O campo $fieldName deve ter no mínimo $minLength caracteres';
    }

    return null;
  }

  /// Valida um número de processo (apenas dígitos)
  static String? validateProcessNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'O número do processo é obrigatório';
    }

    return ProcessNumberValidator.getValidationError(value);
  }

  /// Valida uma data
  static String? validateDate(DateTime? date, String fieldName) {
    if (date == null) {
      return 'A data $fieldName é obrigatória';
    }

    if (date.isAfter(DateTime.now())) {
      return 'A data $fieldName não pode ser no futuro';
    }

    return null;
  }

  /// Valida moeda/valor monetário (apenas números)
  static String? validateCurrency(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return null; // Campo opcional
    }

    // Aceita números com ponto ou vírgula como separador decimal
    final currencyRegex = RegExp(r'^\d+([.,]\d{1,2})?$');
    if (!currencyRegex.hasMatch(value)) {
      return 'Use apenas números. Ex: 1500.50 ou 1500,50';
    }

    return null;
  }

  /// Exibe um DialogBox de erro crítico
  static Future<void> showErrorDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    if (!context.mounted) return;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  /// Log de erro 
  static void logError(String source, dynamic error, StackTrace? stackTrace) {
    debugPrint(
      'X [$source] Erro: $error\n'
      'Stack Trace: ${stackTrace.toString()}',
    );
  }
}
