import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfect_numbers/app/features/perfect_number/presentation/cubits/settings/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void toggleTheme() => emit(state.copyWith(
    themeMode: state.isDark ? ThemeMode.light : ThemeMode.dark,
  ));

  void setLanguage(String lang) => emit(state.copyWith(language: lang));

  void toggleComputationAlerts() => emit(state.copyWith(
    computationAlerts: !state.computationAlerts,
  ));
}
