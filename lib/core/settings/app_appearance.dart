import 'package:flutter/material.dart';

enum AppAppearance {
  system,
  light,
  dark,
  amoledBlack;

  static AppAppearance fromStorage(String raw) {
    return switch (raw) {
      'light' => AppAppearance.light,
      'dark' => AppAppearance.dark,
      'amoled' => AppAppearance.amoledBlack,
      'system' => AppAppearance.system,
      _ => AppAppearance.system,
    };
  }

  String toStorage() {
    return switch (this) {
      AppAppearance.system => 'system',
      AppAppearance.light => 'light',
      AppAppearance.dark => 'dark',
      AppAppearance.amoledBlack => 'amoled',
    };
  }

  ThemeMode get materialThemeMode {
    return switch (this) {
      AppAppearance.system => ThemeMode.system,
      AppAppearance.light => ThemeMode.light,
      AppAppearance.dark || AppAppearance.amoledBlack => ThemeMode.dark,
    };
  }
}
