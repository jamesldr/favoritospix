import 'package:brasil_fields/brasil_fields.dart';

class AppFormValidator {
  static String? email(String? value, {String error = 'Email inválido'}) {
    String emailRegex =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    if (!RegExp(emailRegex).hasMatch(value ?? "")) return error;
    return null;
  }

  static String? validateCpf(String? value, {String error = 'CPF inválido'}) {
    String numbers = CPFValidator.strip(value ?? "");
    if (numbers.length != 11 || !CPFValidator.isValid(value ?? "")) {
      return error;
    }
    return null;
  }

  static String? validateCnpj(String? value, {String error = 'CNPJ inválido'}) {
    String numbers = CNPJValidator.strip(value ?? "");
    if (numbers.length != 14 || !CNPJValidator.isValid(value ?? "")) {
      return error;
    }
    return null;
  }

  static String? cpfOrCnpj(
    String? value, {
    String errorCPF = 'CPF inválido',
    String errorCNPJ = 'CNPJ inválido',
  }) {
    String? response = validateCpf(value, error: errorCPF);
    if (response != null) response = validateCnpj(value, error: errorCNPJ);
    return response;
  }

  static String? phone(String? value, {String error = 'Telefone inválido'}) {
    final number = (value ?? "").replaceAll(RegExp(r'[^0-9]'), '');
    if (number.trim().length < 10) return error;
    return null;
  }
}
