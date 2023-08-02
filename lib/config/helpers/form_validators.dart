class FormValidators {
  static String? validateDate(String? value, [bool canBeEmpty = false]) {
    if (value == null || value.isEmpty) {
      if (canBeEmpty) {
        return null;
      } else {
        return 'Por favor ingrese una fecha.';
      }
    }

    final RegExp fechaExp = RegExp(r'^\d{2}\/\d{2}\/\d{4}$');
    if (!fechaExp.hasMatch(value)) {
      return 'Ingrese la fecha en el formato correcto: DD/MM/YYYY.';
    }

    return null;
  }

  static String? validateEmail(String? value, [bool canBeEmpty = false]) {
    if (value == null || value.isEmpty) {
      if (canBeEmpty) {
        return null;
      } else {
        return 'Por favor ingrese un correo electrónico.';
      }
    }
    final RegExp emailExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!emailExp.hasMatch(value)) {
      return 'Ingrese un correo electrónico válido.';
    }

    return null;
  }

  static String? validateInteger(String? valor, [bool canBeEmpty = false]) {
    if (valor == null || valor.isEmpty) {
      if (canBeEmpty) {
        return null;
      } else {
        return 'Por favor ingrese un número.';
      }
    }

    if (!RegExp(r'^\d+$').hasMatch(valor)) {
      return 'Por favor ingrese un número válido.';
    }

    return null;
  }

  static String? validateNumber(String? valor, [bool canBeEmpty = false]) {
    if (valor == null || valor.isEmpty) {
      if (canBeEmpty) {
        return null;
      } else {
        return 'Por favor ingrese un número';
      }
    }

    if (!RegExp(r'^\d+\.?\d*$').hasMatch(valor)) {
      return 'Por favor ingrese un número válido';
    }

    return null;
  }

  static String? validateCurp(String? valor, [bool canBeEmpty = false]) {
    if (valor == null || valor.isEmpty) {
      if (canBeEmpty) {
        return null;
      } else {
        return 'Por favor ingrese un CURP';
      }
    }

    if (!RegExp(r'^[A-Z]{4}\d{6}[H,M][A-Z]{5}[A-Z0-9]{2}$').hasMatch(valor)) {
      return 'Por favor ingrese un CURP válido';
    }

    return null;
  }

  static String? validateNumberCreditCard(String? valor,
      [bool canBeEmpty = false]) {
    if (valor == null || valor.isEmpty) {
      if (canBeEmpty) {
        return null;
      } else {
        return 'Por favor ingrese el número de la tarjeta';
      }
    }
    valor = valor.replaceAll(' ', '');

    if (!_esNumeroTarjetaValido(valor)) {
      return 'Por favor ingrese un número de tarjeta válido';
    }

    return null;
  }

  static String? validatePassword(String? value, [bool canBeEmpty = false]) {
    if (value == null || value.isEmpty) {
      if (canBeEmpty) {
        return null;
      } else {
        return 'Por favor ingrese una contraseña.';
      }
    }

    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres.';
    }

    if (!RegExp(r'\d').hasMatch(value)) {
      return 'La contraseña debe contener un número.';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'La contraseña debe contener una letra mayúscula.';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'La contraseña debe contener una letra minúscula.';
    }

    return null;
  }

  static String? validatePasswordConfirmation(String? value, String? original,
      [bool canBeEmpty = false]) {
    if (value == null || value.isEmpty) {
      if (canBeEmpty) {
        return null;
      } else {
        return 'Por favor confirme la contraseña.';
      }
    }

    if (value != original) {
      return 'Las contraseñas no coinciden.';
    }

    return null;
  }

  static String? validateNotNull(String? value, String data) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese $data.';
    }
    return null;
  }

  static bool _esNumeroTarjetaValido(String valor) {
    int sum = 0;
    int length = valor.length;
    for (int i = 0; i < length; i++) {
      int digit = int.parse(valor[length - i - 1]);

      if (i % 2 == 1) {
        digit *= 2;
      }

      if (digit > 9) {
        digit -= 9;
      }

      sum += digit;
    }

    return sum % 10 == 0;
  }
}
