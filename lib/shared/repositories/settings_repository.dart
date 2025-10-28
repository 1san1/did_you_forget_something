import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:did_you_forget_something/shared/services/local_storage_service.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final storage = ref.watch(localStorageServiceProvider);
  return SettingsRepository(storage);
});

class SettingsRepository {
  SettingsRepository(this._storage);

  static const _themeModeKey = 'theme_mode';

  final LocalStorageService _storage;

  ThemeMode loadThemeMode() {
    final index = _storage.getSetting<int>(_themeModeKey);
    if (index == null) {
      return ThemeMode.system;
    }
    return ThemeMode.values[index.clamp(0, ThemeMode.values.length - 1)];
  }

  Future<void> saveThemeMode(ThemeMode mode) {
    return _storage.setSetting<int>(_themeModeKey, mode.index);
  }

  Stream<ThemeMode> watchThemeMode() {
    return _storage
        .watchSetting<int>(_themeModeKey)
        .map((index) => index == null
            ? ThemeMode.system
            : ThemeMode.values[index.clamp(0, ThemeMode.values.length - 1)]);
  }
}
