import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:did_you_forget_something/shared/repositories/settings_repository.dart';

final themeControllerProvider =
    StateNotifierProvider<ThemeController, ThemeMode>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return ThemeController(repository);
});

class ThemeController extends StateNotifier<ThemeMode> {
  ThemeController(this._repository) : super(ThemeMode.system) {
    _initialize();
  }

  final SettingsRepository _repository;
  StreamSubscription<ThemeMode>? _subscription;

  Future<void> _initialize() async {
    state = _repository.loadThemeMode();
    _subscription = _repository
        .watchThemeMode()
        .listen((mode) => state = mode, onError: (Object error, StackTrace stackTrace) {
      debugPrint('Failed to listen to theme mode updates: $error');
    });
  }

  Future<void> setThemeMode(ThemeMode mode) {
    state = mode;
    return _repository.saveThemeMode(mode);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
