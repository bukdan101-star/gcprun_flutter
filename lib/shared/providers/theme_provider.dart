import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum ThemeModeOption { light, dark, system }

class ThemeModeState {
  final ThemeModeOption mode;

  const ThemeModeState({this.mode = ThemeModeOption.system});

  ThemeModeState copyWith({ThemeModeOption? mode}) {
    return ThemeModeState(mode: mode ?? this.mode);
  }

  ThemeMode toThemeMode() {
    switch (mode) {
      case ThemeModeOption.light:
        return ThemeMode.light;
      case ThemeModeOption.dark:
        return ThemeMode.dark;
      case ThemeModeOption.system:
        return ThemeMode.system;
    }
  }
}

class ThemeNotifier extends Notifier<ThemeModeState> {
  static const String _themeKey = 'theme_mode';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  ThemeModeState build() {
    _loadTheme();
    return const ThemeModeState();
  }

  Future<void> _loadTheme() async {
    try {
      final saved = await _storage.read(key: _themeKey);
      if (saved != null) {
        final mode = ThemeModeOption.values.firstWhere(
          (e) => e.name == saved,
          orElse: () => ThemeModeOption.system,
        );
        state = ThemeModeState(mode: mode);
      }
    } catch (_) {}
  }

  Future<void> setThemeMode(ThemeModeOption mode) async {
    state = ThemeModeState(mode: mode);
    try {
      await _storage.write(key: _themeKey, value: mode.name);
    } catch (_) {}
  }

  Future<void> toggleTheme() async {
    final current = state.mode;
    final next = current == ThemeModeOption.light
        ? ThemeModeOption.dark
        : ThemeModeOption.light;
    await setThemeMode(next);
  }
}

final themeProvider =
    NotifierProvider<ThemeNotifier, ThemeModeState>(ThemeNotifier.new);
