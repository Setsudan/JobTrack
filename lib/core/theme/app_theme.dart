import 'package:flutter/material.dart';

import 'package:job_application_tracker/core/theme/job_track_palette.dart';

abstract final class AppTheme {
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _black = Color(0xFF000000);

  /// Solid menu surface for [DropdownButton] overlays so options stay readable
  /// when the color scheme uses translucent surfaces (e.g. wallpaper mode).
  static Color dropdownMenuBackground(ColorScheme colorScheme) {
    final Color opaqueBase =
        colorScheme.brightness == Brightness.light ? _white : _black;
    return Color.alphaBlend(colorScheme.surfaceContainerHigh, opaqueBase);
  }
  static const Color _darkElevated = Color(0xFF121212);
  static const Color _darkElevatedHigh = Color(0xFF1E1E1E);
  static const Color _darkElevatedHighest = Color(0xFF2C2C2C);

  static const AppBarThemeData _transparentAppBarTheme = AppBarThemeData(
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.transparent,
  );

  static ThemeData light() {
    final base = ColorScheme.fromSeed(
      seedColor: JobTrackPalette.blue,
      brightness: Brightness.light,
    );
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _white,
      appBarTheme: _transparentAppBarTheme,
      colorScheme: base.copyWith(
        surface: _white,
        surfaceDim: _white,
        surfaceBright: _white,
        surfaceContainerLowest: _white,
        surfaceContainerLow: base.surfaceContainerLow,
        surfaceContainer: base.surfaceContainer,
        surfaceContainerHigh: base.surfaceContainerHigh,
        surfaceContainerHighest: base.surfaceContainerHighest,
      ),
    );
  }

  static ThemeData dark() {
    final base = ColorScheme.fromSeed(
      seedColor: JobTrackPalette.blue,
      brightness: Brightness.dark,
    );
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _black,
      appBarTheme: _transparentAppBarTheme,
      colorScheme: base.copyWith(
        surface: _black,
        surfaceDim: _black,
        surfaceBright: _darkElevated,
        surfaceContainerLowest: _black,
        surfaceContainerLow: _darkElevated,
        surfaceContainer: _darkElevated,
        surfaceContainerHigh: _darkElevatedHigh,
        surfaceContainerHighest: _darkElevatedHighest,
      ),
    );
  }

  static ThemeData amoledBlack() {
    final base = ColorScheme.fromSeed(
      seedColor: JobTrackPalette.blue,
      brightness: Brightness.dark,
    );
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _black,
      appBarTheme: _transparentAppBarTheme,
      colorScheme: base.copyWith(
        surface: _black,
        surfaceDim: _black,
        surfaceBright: _black,
        surfaceContainerLowest: _black,
        surfaceContainerLow: _black,
        surfaceContainer: _black,
        surfaceContainerHigh: _black,
        surfaceContainerHighest: _black,
      ),
    );
  }

  static ThemeData lightWithWallpaper() {
    return _wallpaperChrome(light());
  }

  static ThemeData darkWithWallpaper() {
    return _wallpaperChrome(dark());
  }

  static ThemeData amoledBlackWithWallpaper() {
    return _wallpaperChrome(amoledBlack());
  }

  static ThemeData _wallpaperChrome(ThemeData base) {
    final ColorScheme c = base.colorScheme;
    final double a = c.brightness == Brightness.light ? 0.74 : 0.78;
    Color glass(Color solid) => solid.withValues(alpha: a);

    return base.copyWith(
      scaffoldBackgroundColor: Colors.transparent,
      canvasColor: Colors.transparent,
      colorScheme: c.copyWith(
        surface: glass(c.surface),
        surfaceDim: glass(c.surfaceDim),
        surfaceBright: glass(c.surfaceBright),
        surfaceContainerLowest: glass(c.surfaceContainerLowest),
        surfaceContainerLow: glass(c.surfaceContainerLow),
        surfaceContainer: glass(c.surfaceContainer),
        surfaceContainerHigh: glass(c.surfaceContainerHigh),
        surfaceContainerHighest: glass(c.surfaceContainerHighest),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: glass(c.surfaceContainerHigh),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: glass(c.surfaceContainerHigh),
      ),
      appBarTheme: _transparentAppBarTheme,
    );
  }
}
