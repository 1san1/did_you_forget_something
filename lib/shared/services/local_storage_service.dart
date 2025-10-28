import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  throw UnimplementedError('LocalStorageService has not been initialized.');
});

class LocalStorageService {
  LocalStorageService._(this._settingsBox);

  static const String settingsBoxName = 'settings';
  static const String checklistsBoxName = 'checklists';
  static const String remindersBoxName = 'reminders';
  static const String routinesBoxName = 'routines';

  final Box<dynamic> _settingsBox;

  static Future<LocalStorageService> init() async {
    await Hive.initFlutter();

    final settings = await Hive.openBox<dynamic>(settingsBoxName);
    await Future.wait([
      Hive.openBox<dynamic>(checklistsBoxName),
      Hive.openBox<dynamic>(remindersBoxName),
      Hive.openBox<dynamic>(routinesBoxName),
    ]);

    return LocalStorageService._(settings);
  }

  T? getSetting<T>(String key) {
    final value = _settingsBox.get(key);
    if (value is T? || value == null) {
      return value as T?;
    }
    if (kDebugMode) {
      throw StateError('Unexpected value type for "$key": ${value.runtimeType}');
    }
    return null;
  }

  Future<void> setSetting<T>(String key, T value) {
    return _settingsBox.put(key, value);
  }

  Stream<T?> watchSetting<T>(String key) async* {
    yield getSetting<T>(key);
    yield* _settingsBox.watch(key: key).map((event) => event.value as T?);
  }

  Future<void> clearSetting(String key) => _settingsBox.delete(key);
}
