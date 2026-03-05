import 'package:flutter/services.dart';

class ThousandSeparatorFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digitsOnly = newValue.text.replaceAll('.', '');

    if (digitsOnly.isEmpty) {
      return newValue.copyWith(text: '');
    }

    if (int.tryParse(digitsOnly) == null) {
      return oldValue;
    }

    final formatted = _format(digitsOnly);

    final oldCursorPos = newValue.selection.baseOffset;
    final oldDotsBeforeCursor =
        newValue.text.substring(0, oldCursorPos).split('.').length - 1;
    final digitsBeforeCursor = oldCursorPos - oldDotsBeforeCursor;

    int newCursorPos = 0;
    int digitCount = 0;
    for (int i = 0; i < formatted.length; i++) {
      if (formatted[i] != '.') {
        digitCount++;
      }
      if (digitCount == digitsBeforeCursor) {
        newCursorPos = i + 1;
        break;
      }
    }

    if (digitCount < digitsBeforeCursor) {
      newCursorPos = formatted.length;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: newCursorPos),
    );
  }

  static String _format(String digits) {
    final buffer = StringBuffer();
    final length = digits.length;
    for (int i = 0; i < length; i++) {
      buffer.write(digits[i]);
      final remaining = length - 1 - i;
      if (remaining > 0 && remaining % 3 == 0) {
        buffer.write('.');
      }
    }
    return buffer.toString();
  }

  static int? parse(String formatted) {
    return int.tryParse(formatted.replaceAll('.', ''));
  }
}
