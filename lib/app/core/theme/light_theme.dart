import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perfect_numbers/app/core/theme/app_text_styles.dart';

class LightTheme {
  LightTheme._();

  static const Color _background = Color(0xFFF0F8F4);
  static const Color _surface = Color(0xFFFFFFFF);
  static const Color _surfaceVariant = Color(0xFFE8F5EE);
  static const Color _card = Color(0xFFFFFFFF);
  static const Color _cardElevated = Color(0xFFD9F0E4);

  static const Color _primary = Color(0xFF1E9E55);
  static const Color _primaryDark = Color(0xFF157A40);
  static const Color _primaryContainer = Color(0xFFD9F0E4);

  static const Color _textPrimary = Color(0xFF0D2417);
  static const Color _textSecondary = Color(0xFF3D6B50);
  static const Color _textMuted = Color(0xFF6B8573);
  static const Color _textOnPrimary = Color(0xFFFFFFFF);

  static const Color _error = Color(0xFFB00020);

  static const Color _border = Color(0xFFB2D8C2);
  static const Color _divider = Color(0xFFCCEBD9);

  static const Color _navSelected = Color(0xFF1E9E55);
  static const Color _navUnselected = Color(0xFF6B8573);

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: _background,
    colorScheme: const ColorScheme.light(
      primary: _primary,
      onPrimary: _textOnPrimary,
      primaryContainer: _primaryContainer,
      onPrimaryContainer: _primaryDark,
      secondary: _primaryDark,
      onSecondary: _textOnPrimary,
      surface: _surface,
      onSurface: _textPrimary,
      onSurfaceVariant: _textSecondary,
      error: _error,
      onError: _textOnPrimary,
      outline: _border,
      outlineVariant: _divider,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: _background,
      foregroundColor: _textPrimary,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: _textPrimary,
      ),
      iconTheme: IconThemeData(color: _textPrimary),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: _card,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: _border),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: _primary,
        foregroundColor: _textOnPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        textStyle: AppTextStyles.button,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _primary,
        side: const BorderSide(color: _primary),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        textStyle: AppTextStyles.button,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _textSecondary,
        textStyle: AppTextStyles.bodyMedium,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _surfaceVariant,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: _primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: _error),
      ),
      hintStyle: const TextStyle(color: _textMuted, fontSize: 16),
      labelStyle: const TextStyle(color: _textSecondary),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: _surface,
      selectedItemColor: _navSelected,
      unselectedItemColor: _navUnselected,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: AppTextStyles.labelSmall,
      unselectedLabelStyle: AppTextStyles.labelSmall,
    ),
    dividerTheme: const DividerThemeData(
      color: _divider,
      thickness: 1,
      space: 1,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? _textOnPrimary : _textMuted,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected) ? _primary : _surfaceVariant,
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: _primary),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: _cardElevated,
      contentTextStyle: const TextStyle(color: _textPrimary),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    tabBarTheme: const TabBarThemeData(
      labelColor: _primary,
      unselectedLabelColor: _textMuted,
      indicatorColor: _primary,
      dividerColor: Colors.transparent,
      labelStyle: AppTextStyles.titleMedium,
      unselectedLabelStyle: AppTextStyles.titleMedium,
    ),
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    ),
  );
}
