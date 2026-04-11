enum AppBackgroundKind {
  none,
  image,
  gradient,
  gradientAnimated,
}

abstract final class AppBackgroundKindStorage {
  static const String none = 'none';
  static const String image = 'image';
  static const String gradient = 'gradient';
  static const String gradientAnimated = 'gradientAnimated';

  static AppBackgroundKind fromRaw(String? raw) {
    return switch (raw) {
      image => AppBackgroundKind.image,
      gradient => AppBackgroundKind.gradient,
      gradientAnimated => AppBackgroundKind.gradientAnimated,
      _ => AppBackgroundKind.none,
    };
  }

  static String toRaw(AppBackgroundKind kind) {
    return switch (kind) {
      AppBackgroundKind.none => none,
      AppBackgroundKind.image => image,
      AppBackgroundKind.gradient => gradient,
      AppBackgroundKind.gradientAnimated => gradientAnimated,
    };
  }
}
