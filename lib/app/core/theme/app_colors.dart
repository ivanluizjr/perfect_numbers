import 'package:flutter/material.dart';

class AppColors {
  const AppColors._({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.card,
    required this.cardElevated,
    required this.primaryMuted,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.successSubtle,
    required this.errorSubtle,
    required this.border,
    required this.divider,
    required this.navUnselected,
    required this.overlay,
  });

  // Theme-dependent instance fields
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color card;
  final Color cardElevated;
  final Color primaryMuted;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color successSubtle;
  final Color errorSubtle;
  final Color border;
  final Color divider;
  final Color navUnselected;
  final Color overlay;

  // Theme-invariant static constants
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

  // Dark theme instance
  static const AppColors dark = AppColors._(
    background: Color(0xFF0D2417),
    surface: Color(0xFF132D1E),
    surfaceVariant: Color(0xFF1A3A26),
    card: Color(0xFF1A3A26),
    cardElevated: Color(0xFF1F4530),
    primaryMuted: Color(0xFF3D6B50),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFB0C4B8),
    textMuted: Color(0xFF6B8573),
    successSubtle: Color(0xFF1A3A26),
    errorSubtle: Color(0xFF3A1A1A),
    border: Color(0xFF1F4530),
    divider: Color(0xFF1A3A26),
    navUnselected: Color(0xFF6B8573),
    overlay: Color(0x80000000),
  );

  // Light theme instance
  static const AppColors light = AppColors._(
    background: Color(0xFFF0F8F4),
    surface: Color(0xFFFFFFFF),
    surfaceVariant: Color(0xFFE4F2EB),
    card: Color(0xFFFFFFFF),
    cardElevated: Color(0xFFE4F2EB),
    primaryMuted: Color(0xFFB3E5C8),
    textPrimary: Color(0xFF0D2417),
    textSecondary: Color(0xFF3D6B50),
    textMuted: Color(0xFF7B9E8A),
    successSubtle: Color(0xFFE4F2EB),
    errorSubtle: Color(0xFFFFEBEE),
    border: Color(0xFFB3E5C8),
    divider: Color(0xFFE4F2EB),
    navUnselected: Color(0xFF7B9E8A),
    overlay: Color(0x40000000),
  );

  // Context-aware factory
  static AppColors of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? dark : light;
}
