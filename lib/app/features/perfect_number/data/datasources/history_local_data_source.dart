import 'dart:convert';

import 'package:perfect_numbers/app/core/errors/errors.dart';
import 'package:perfect_numbers/app/features/perfect_number/data/models/history_entry_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryLocalDataSource {
  final SharedPreferences _prefs;
  static const _key = 'history_entries';
  static const _onboardingKey = 'onboarding_seen';

  const HistoryLocalDataSource(this._prefs);

  List<HistoryEntryModel> getAll() {
    try {
      final raw = _prefs.getString(_key);
      if (raw == null) return [];
      final list = jsonDecode(raw) as List;
      return list
          .map((e) => HistoryEntryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw CacheException(
        message: 'Erro ao carregar histórico.',
        details: e.toString(),
      );
    }
  }

  Future<void> save(HistoryEntryModel model) async {
    try {
      final all = getAll();
      all.insert(0, model);
      await _prefs.setString(
        _key,
        jsonEncode(all.map((e) => e.toJson()).toList()),
      );
    } on CacheException {
      rethrow;
    } catch (e) {
      throw CacheException(
        message: 'Erro ao salvar no histórico.',
        details: e.toString(),
      );
    }
  }

  Future<void> delete(String id) async {
    try {
      final all = getAll()..removeWhere((e) => e.id == id);
      await _prefs.setString(
        _key,
        jsonEncode(all.map((e) => e.toJson()).toList()),
      );
    } on CacheException {
      rethrow;
    } catch (e) {
      throw CacheException(
        message: 'Erro ao deletar entrada do histórico.',
        details: e.toString(),
      );
    }
  }

  Future<void> toggleFavorite(String id) async {
    try {
      final all = getAll();
      final idx = all.indexWhere((e) => e.id == id);
      if (idx == -1) return;
      all[idx] = all[idx].copyWith(isFavorite: !all[idx].isFavorite);
      await _prefs.setString(
        _key,
        jsonEncode(all.map((e) => e.toJson()).toList()),
      );
    } on CacheException {
      rethrow;
    } catch (e) {
      throw CacheException(
        message: 'Erro ao atualizar favorito.',
        details: e.toString(),
      );
    }
  }

  Future<void> clearAll() async {
    try {
      await _prefs.remove(_key);
    } catch (e) {
      throw CacheException(
        message: 'Erro ao limpar histórico.',
        details: e.toString(),
      );
    }
  }

  bool get onboardingSeen => _prefs.getBool(_onboardingKey) ?? false;
  Future<void> markOnboardingSeen() => _prefs.setBool(_onboardingKey, true);
}
