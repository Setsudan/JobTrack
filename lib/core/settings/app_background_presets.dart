import 'package:flutter/material.dart';

enum WallpaperMotion {
  diagonalSweep,
  radialPulse,
  orbitLinear,
  colorOscillation,
  shiftingStops,
  slowRotation,
  waveEndSweep,
  orbitElliptic,
}

final class AnimatedWallpaperSpec {
  const AnimatedWallpaperSpec({
    required this.colors,
    required this.motion,
    required this.duration,
    this.stops,
    this.altColors,
  });

  final List<Color> colors;
  final List<double>? stops;
  final List<Color>? altColors;
  final WallpaperMotion motion;
  final Duration duration;
}

abstract final class AppBackgroundPresets {
  static const List<String> staticPresetIds = <String>[
    oceanId,
    sunsetId,
    twilightId,
    sageId,
    coralId,
    glacierId,
    midnightId,
    lavenderId,
    roseGoldId,
    sandDuneId,
    cherryMistId,
  ];

  static const List<String> animatedPresetIds = <String>[
    auroraId,
    emberId,
    nebulaId,
    prismId,
    tideId,
    cometId,
    forgeId,
    meadowId,
  ];

  static const String oceanId = 'ocean';
  static const String sunsetId = 'sunset';
  static const String twilightId = 'twilight';
  static const String sageId = 'sage';
  static const String coralId = 'coral';
  static const String glacierId = 'glacier';
  static const String midnightId = 'midnight';
  static const String lavenderId = 'lavender';
  static const String roseGoldId = 'roseGold';
  static const String sandDuneId = 'sandDune';
  static const String cherryMistId = 'cherryMist';

  static const String auroraId = 'aurora';
  static const String emberId = 'ember';
  static const String nebulaId = 'nebula';
  static const String prismId = 'prism';
  static const String tideId = 'tide';
  static const String cometId = 'comet';
  static const String forgeId = 'forge';
  static const String meadowId = 'meadow';

  static LinearGradient? staticGradient(String? presetId) {
    return switch (presetId) {
      oceanId => const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF0F4C75),
            Color(0xFF3282B8),
            Color(0xFFBBE1FA),
          ],
        ),
      sunsetId => const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFFFF6B6B),
            Color(0xFFFFE66D),
            Color(0xFFFF8E53),
          ],
        ),
      twilightId => const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Color(0xFF2D1B69),
            Color(0xFF11998E),
            Color(0xFF38EF7D),
          ],
        ),
      sageId => const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[
            Color(0xFF134E5E),
            Color(0xFF71B280),
          ],
        ),
      coralId => const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: <Color>[
            Color(0xFFFF5F6D),
            Color(0xFFFFC371),
            Color(0xFFFFE8D6),
          ],
        ),
      glacierId => const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFF83A4D4),
            Color(0xFFB6FBFF),
            Color(0xFFE8F4F8),
          ],
        ),
      midnightId => const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFF0F2027),
            Color(0xFF203A43),
            Color(0xFF2C5364),
          ],
        ),
      lavenderId => const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Color(0xFFB993D6),
            Color(0xFF8CA6DB),
            Color(0xFFD4E4F7),
          ],
        ),
      roseGoldId => const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[
            Color(0xFFF4C4F3),
            Color(0xFFFC67FA),
            Color(0xFFF4AB6A),
          ],
        ),
      sandDuneId => const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFFC79081),
            Color(0xFFDFA579),
            Color(0xFFF3E7DD),
          ],
        ),
      cherryMistId => const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: <Color>[
            Color(0xFF2F0743),
            Color(0xFF41295A),
            Color(0xFF7B5F8A),
            Color(0xFFE8D5F2),
          ],
        ),
      _ => null,
    };
  }

  static AnimatedWallpaperSpec? animatedSpec(String? presetId) {
    return switch (presetId) {
      auroraId => const AnimatedWallpaperSpec(
          colors: <Color>[
            Color(0xFF7F00FF),
            Color(0xFFE100FF),
            Color(0xFF00C9FF),
          ],
          motion: WallpaperMotion.diagonalSweep,
          duration: Duration(seconds: 12),
        ),
      emberId => const AnimatedWallpaperSpec(
          colors: <Color>[
            Color(0xFF200122),
            Color(0xFF6F0000),
            Color(0xFFFF6A00),
            Color(0xFFFFD194),
          ],
          motion: WallpaperMotion.radialPulse,
          duration: Duration(seconds: 10),
        ),
      nebulaId => const AnimatedWallpaperSpec(
          colors: <Color>[
            Color(0xFF141E30),
            Color(0xFF243B55),
            Color(0xFF53346D),
            Color(0xFFCBAD6D),
          ],
          motion: WallpaperMotion.orbitLinear,
          duration: Duration(seconds: 14),
        ),
      prismId => const AnimatedWallpaperSpec(
          colors: <Color>[
            Color(0xFF4776E6),
            Color(0xFF8E54E9),
            Color(0xFF00D2FF),
          ],
          altColors: <Color>[
            Color(0xFFFF00CC),
            Color(0xFF333399),
            Color(0xFF00FF87),
          ],
          motion: WallpaperMotion.colorOscillation,
          duration: Duration(seconds: 8),
        ),
      tideId => const AnimatedWallpaperSpec(
          colors: <Color>[
            Color(0xFF13547A),
            Color(0xFF80D0C7),
            Color(0xFF4B79A1),
            Color(0xFFE0EAFC),
          ],
          stops: <double>[0, 0.35, 0.65, 1],
          motion: WallpaperMotion.shiftingStops,
          duration: Duration(seconds: 11),
        ),
      cometId => const AnimatedWallpaperSpec(
          colors: <Color>[
            Color(0xFF0C0C0C),
            Color(0xFF1A2980),
            Color(0xFF26D0CE),
          ],
          motion: WallpaperMotion.slowRotation,
          duration: Duration(seconds: 20),
        ),
      forgeId => const AnimatedWallpaperSpec(
          colors: <Color>[
            Color(0xFF3E2723),
            Color(0xFF8D6E63),
            Color(0xFFFFD54F),
            Color(0xFFFFF8E1),
          ],
          motion: WallpaperMotion.waveEndSweep,
          duration: Duration(seconds: 9),
        ),
      meadowId => const AnimatedWallpaperSpec(
          colors: <Color>[
            Color(0xFF134E5E),
            Color(0xFF56AB2F),
            Color(0xFFA8E063),
            Color(0xFFE8F5E9),
          ],
          motion: WallpaperMotion.orbitElliptic,
          duration: Duration(seconds: 13),
        ),
      _ => null,
    };
  }

  static String defaultStaticPresetId() => oceanId;

  static String defaultAnimatedPresetId() => auroraId;

  static String resolveStaticPresetId(String? stored) {
    if (stored != null &&
        stored.isNotEmpty &&
        staticGradient(stored) != null) {
      return stored;
    }
    return defaultStaticPresetId();
  }

  static String resolveAnimatedPresetId(String? stored) {
    if (stored != null &&
        stored.isNotEmpty &&
        animatedSpec(stored) != null) {
      return stored;
    }
    return defaultAnimatedPresetId();
  }
}
