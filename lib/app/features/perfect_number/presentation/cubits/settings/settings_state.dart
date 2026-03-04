import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsState extends Equatable {
  final ThemeMode themeMode;
  final String language;
  final bool computationAlerts;

  const SettingsState({
    this.themeMode = ThemeMode.dark,
    this.language = 'Português',
    this.computationAlerts = true,
  });

  SettingsState copyWith({ThemeMode? themeMode, String? language, bool? computationAlerts}) =>
      SettingsState(
        themeMode: themeMode ?? this.themeMode,
        language: language ?? this.language,
        computationAlerts: computationAlerts ?? this.computationAlerts,
      );

  bool get isDark => themeMode == ThemeMode.dark;

  @override
  List<Object?> get props => [themeMode, language, computationAlerts];
}
