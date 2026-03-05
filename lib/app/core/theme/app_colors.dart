import 'package:flutter/material.dart';

class AppThemeColors {
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color card;
  final Color cardElevated;
  final Color primary;
  final Color primaryLight;
  final Color primaryDark;
  final Color primaryMuted;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color textOnPrimary;
  final Color success;
  final Color successSubtle;
  final Color error;
  final Color errorSubtle;
  final Color warning;
  final Color info;
  final Color border;
  final Color divider;
  final Color navSelected;
  final Color navUnselected;
  final LinearGradient primaryGradient;
  final Color overlay;

  const AppThemeColors({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.card,
    required this.cardElevated,
    required this.primary,
    required this.primaryLight,
    required this.primaryDark,
    required this.primaryMuted,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.textOnPrimary,
    required this.success,
    required this.successSubtle,
    required this.error,
    required this.errorSubtle,
    required this.warning,
    required this.info,
    required this.border,
    required this.divider,
    required this.navSelected,
    required this.navUnselected,
    required this.primaryGradient,
    required this.overlay,
  });
}

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF2ECC71);
  static const Color primaryLight = Color(0xFF00E676);
  static const Color primaryDark = Color(0xFF1B9E55);
  static const Color textOnPrimary = Color(0xFF0D2417);
  static const Color success = Color(0xFF2ECC71);
  static const Color error = Color(0xFFE57373);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF4FC3F7);
  static const Color navSelected = Color(0xFF2ECC71);
  static const Color transparent = Colors.transparent;
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2ECC71), Color(0xFF1B9E55)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static AppThemeColors of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark ? dark : light;
  }

  static const dark = AppThemeColors(
    background: Color(0xFF0D2417),
    surface: Color(0xFF132D1E),
    surfaceVariant: Color(0xFF1A3A26),
    card: Color(0xFF1A3A26),
    cardElevated: Color(0xFF1F4530),
    primary: Color(0xFF2ECC71),
    primaryLight: Color(0xFF00E676),
    primaryDark: Color(0xFF1B9E55),
    primaryMuted: Color(0xFF3D6B50),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFB0C4B8),
    textMuted: Color(0xFF6B8573),
    textOnPrimary: Color(0xFF0D2417),
    success: Color(0xFF2ECC71),
    successSubtle: Color(0xFF1A3A26),
    error: Color(0xFFE57373),
    errorSubtle: Color(0xFF3A1A1A),
    warning: Color(0xFFFFB74D),
    info: Color(0xFF4FC3F7),
    border: Color(0xFF1F4530),
    divider: Color(0xFF1A3A26),
    navSelected: Color(0xFF2ECC71),
    navUnselected: Color(0xFF6B8573),
    primaryGradient: LinearGradient(
      colors: [Color(0xFF2ECC71), Color(0xFF1B9E55)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    overlay: Color(0x80000000),
  );

  static const light = AppThemeColors(
    background: Color(0xFFF0F8F4),
    surface: Color(0xFFFFFFFF),
    surfaceVariant: Color(0xFFE8F5EE),
    card: Color(0xFFFFFFFF),
    cardElevated: Color(0xFFD9F0E4),
    primary: Color(0xFF1E9E55),
    primaryLight: Color(0xFF2ECC71),
    primaryDark: Color(0xFF157A40),
    primaryMuted: Color(0xFF7DB89A),
    textPrimary: Color(0xFF0D2417),
    textSecondary: Color(0xFF3D6B50),
    textMuted: Color(0xFF6B8573),
    textOnPrimary: Color(0xFFFFFFFF),
    success: Color(0xFF1E9E55),
    successSubtle: Color(0xFFD9F0E4),
    error: Color(0xFFB00020),
    errorSubtle: Color(0xFFFFDAD6),
    warning: Color(0xFFFFB74D),
    info: Color(0xFF0277BD),
    border: Color(0xFFB2D8C2),
    divider: Color(0xFFCCEBD9),
    navSelected: Color(0xFF1E9E55),
    navUnselected: Color(0xFF6B8573),
    primaryGradient: LinearGradient(
      colors: [Color(0xFF1E9E55), Color(0xFF157A40)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    overlay: Color(0x80000000),
  );
}
