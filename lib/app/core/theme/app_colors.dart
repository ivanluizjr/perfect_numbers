import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFF0D2417);
  static const Color surface = Color(0xFF132D1E);
  static const Color surfaceVariant = Color(0xFF1A3A26);
  static const Color card = Color(0xFF1A3A26);
  static const Color cardElevated = Color(0xFF1F4530);

  static const Color primary = Color(0xFF2ECC71);
  static const Color primaryLight = Color(0xFF00E676);
  static const Color primaryDark = Color(0xFF1B9E55);
  static const Color primaryMuted = Color(0xFF3D6B50);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0C4B8);
  static const Color textMuted = Color(0xFF6B8573);
  static const Color textOnPrimary = Color(0xFF0D2417);

  static const Color success = Color(0xFF2ECC71);
  static const Color successSubtle = Color(0xFF1A3A26);
  static const Color error = Color(0xFFE57373);
  static const Color errorSubtle = Color(0xFF3A1A1A);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF4FC3F7);

  static const Color border = Color(0xFF1F4530);
  static const Color divider = Color(0xFF1A3A26);

  static const Color navSelected = Color(0xFF2ECC71);
  static const Color navUnselected = Color(0xFF6B8573);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2ECC71), Color(0xFF1B9E55)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color overlay = Color(0x80000000);
  static const Color transparent = Colors.transparent;
}
