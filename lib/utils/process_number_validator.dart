/// Validador simplificado de números de processo
class ProcessNumberValidator {
  /// Valida se o número de processo contém apenas dígitos
  static bool isValidProcessNumber(String numero) {
    return getValidationError(numero) == null;
  }

  /// Retorna mensagem de erro ou null se válido
  static String? getValidationError(String numero) {
    if (numero.isEmpty) {
      return 'Número do processo é obrigatório';
    }

    // Remover caracteres especiais e verificar se restou apenas dígitos
    final onlyDigits = numero.replaceAll(RegExp(r'[^0-9]'), '');

    if (onlyDigits.isEmpty) {
      return 'O número do processo deve conter apenas dígitos';
    }

    return null;
  }
}
