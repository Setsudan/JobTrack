import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:job_application_tracker/core/settings/app_background_kind.dart';
import 'package:job_application_tracker/core/settings/app_background_presets.dart';
import 'package:job_application_tracker/core/settings/settings_controller.dart';
import 'package:job_application_tracker/core/ui/gaussian_blur_filter.dart';

class AppWallpaper extends StatelessWidget {
  const AppWallpaper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsController>(
      builder: (context, settings, _) {
        if (!settings.wallpaperActive) {
          final Color fill = Theme.of(context).colorScheme.surface;
          return ColoredBox(color: fill, child: const SizedBox.expand());
        }
        final AppBackgroundKind kind = settings.appBackgroundKind;
        switch (kind) {
          case AppBackgroundKind.none:
            break;
          case AppBackgroundKind.image:
            final File? f = settings.backgroundImageFileIfExists();
            if (f != null) {
              return _WallpaperImageLayer(file: f);
            }
            break;
          case AppBackgroundKind.gradient:
            final String id = AppBackgroundPresets.resolveStaticPresetId(
              settings.appBackgroundPresetId,
            );
            final LinearGradient? g = AppBackgroundPresets.staticGradient(id);
            if (g != null) {
              return _WallpaperGradientLayer(gradient: g);
            }
            break;
          case AppBackgroundKind.gradientAnimated:
            final String id = AppBackgroundPresets.resolveAnimatedPresetId(
              settings.appBackgroundPresetId,
            );
            final AnimatedWallpaperSpec? spec =
                AppBackgroundPresets.animatedSpec(id);
            if (spec != null) {
              return RepaintBoundary(
                child: _AnimatedWallpaperDispatcher(
                  key: ValueKey<String>(id),
                  spec: spec,
                ),
              );
            }
            break;
        }
        final Color fill = Theme.of(context).colorScheme.surface;
        return ColoredBox(color: fill, child: const SizedBox.expand());
      },
    );
  }
}

class _WallpaperImageLayer extends StatelessWidget {
  const _WallpaperImageLayer({required this.file});

  final File file;

  static const double _gradientBlurSigmaSoft = 9;
  static const double _gradientBlurSigmaStrong = 26;

  @override
  Widget build(BuildContext context) {
    final bool dark = Theme.of(context).brightness == Brightness.dark;
    final FileImage imageProvider = FileImage(file);
    final BoxDecoration imageDecoration = BoxDecoration(
      image: DecorationImage(
        image: imageProvider,
        fit: BoxFit.cover,
      ),
    );
    return RepaintBoundary(
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: imageDecoration,
            child: const SizedBox.expand(),
          ),
          Positioned.fill(
            child: ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[
                    Color(0xF5FFFFFF),
                    Color(0xA0FFFFFF),
                    Color(0x38FFFFFF),
                    Color(0x00FFFFFF),
                  ],
                  stops: <double>[0, 0.32, 0.62, 0.9],
                ).createShader(bounds);
              },
              child: ImageFiltered(
                imageFilter: gaussianBlurFilter(
                  sigmaX: _gradientBlurSigmaSoft,
                  sigmaY: _gradientBlurSigmaSoft,
                ),
                child: DecoratedBox(
                  decoration: imageDecoration,
                  child: const SizedBox.expand(),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment(0, -0.15),
                  colors: <Color>[
                    Color(0xFFFFFFFF),
                    Color(0xD9FFFFFF),
                    Color(0x55FFFFFF),
                    Color(0x00FFFFFF),
                  ],
                  stops: <double>[0, 0.12, 0.32, 0.52],
                ).createShader(bounds);
              },
              child: ImageFiltered(
                imageFilter: gaussianBlurFilter(
                  sigmaX: _gradientBlurSigmaStrong,
                  sigmaY: _gradientBlurSigmaStrong,
                ),
                child: DecoratedBox(
                  decoration: imageDecoration,
                  child: const SizedBox.expand(),
                ),
              ),
            ),
          ),
          if (dark)
            ColoredBox(
              color: Colors.black.withValues(alpha: 0.38),
              child: const SizedBox.expand(),
            ),
        ],
      ),
    );
  }
}

class _WallpaperGradientLayer extends StatelessWidget {
  const _WallpaperGradientLayer({required this.gradient});

  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    final bool dark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      fit: StackFit.expand,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(gradient: gradient),
          child: const SizedBox.expand(),
        ),
        if (dark)
          ColoredBox(
            color: Colors.black.withValues(alpha: 0.22),
            child: const SizedBox.expand(),
          ),
      ],
    );
  }
}

class _AnimatedWallpaperDispatcher extends StatelessWidget {
  const _AnimatedWallpaperDispatcher({
    super.key,
    required this.spec,
  });

  final AnimatedWallpaperSpec spec;

  @override
  Widget build(BuildContext context) {
    return switch (spec.motion) {
      WallpaperMotion.diagonalSweep =>
        _AnimatedDiagonalSweep(spec: spec),
      WallpaperMotion.radialPulse => _AnimatedRadialPulse(spec: spec),
      WallpaperMotion.orbitLinear => _AnimatedOrbitLinear(spec: spec),
      WallpaperMotion.colorOscillation =>
        _AnimatedColorOscillation(spec: spec),
      WallpaperMotion.shiftingStops => _AnimatedShiftingStops(spec: spec),
      WallpaperMotion.slowRotation => _AnimatedSlowRotation(spec: spec),
      WallpaperMotion.waveEndSweep => _AnimatedWaveEndSweep(spec: spec),
      WallpaperMotion.orbitElliptic => _AnimatedOrbitElliptic(spec: spec),
    };
  }
}

abstract class _AnimatedGradientBase extends StatefulWidget {
  const _AnimatedGradientBase({required this.spec});

  final AnimatedWallpaperSpec spec;
}

abstract class _AnimatedGradientBaseState<T extends _AnimatedGradientBase>
    extends State<T> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  AnimatedWallpaperSpec get spec => widget.spec;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: spec.duration,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget darkScrimIfNeeded(BuildContext context, Widget child) {
    final bool dark = Theme.of(context).brightness == Brightness.dark;
    if (!dark) {
      return child;
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        ColoredBox(
          color: Colors.black.withValues(alpha: 0.22),
          child: const SizedBox.expand(),
        ),
      ],
    );
  }
}

class _AnimatedDiagonalSweep extends _AnimatedGradientBase {
  const _AnimatedDiagonalSweep({required super.spec});

  @override
  State<_AnimatedDiagonalSweep> createState() =>
      _AnimatedDiagonalSweepState();
}

class _AnimatedDiagonalSweepState extends _AnimatedGradientBaseState<_AnimatedDiagonalSweep> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        final double t = Curves.easeInOut.transform(_controller.value);
        final Alignment begin = Alignment.lerp(
          Alignment.topLeft,
          Alignment.bottomRight,
          t,
        )!;
        final Alignment end = Alignment.lerp(
          Alignment.bottomRight,
          Alignment.topLeft,
          t,
        )!;
        final LinearGradient g = LinearGradient(
          begin: begin,
          end: end,
          colors: spec.colors,
          stops: spec.stops,
        );
        return darkScrimIfNeeded(
          context,
          DecoratedBox(
            decoration: BoxDecoration(gradient: g),
            child: const SizedBox.expand(),
          ),
        );
      },
    );
  }
}

class _AnimatedRadialPulse extends _AnimatedGradientBase {
  const _AnimatedRadialPulse({required super.spec});

  @override
  State<_AnimatedRadialPulse> createState() => _AnimatedRadialPulseState();
}

class _AnimatedRadialPulseState
    extends _AnimatedGradientBaseState<_AnimatedRadialPulse> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        final double t = _controller.value;
        final double wave = math.sin(t * math.pi * 2);
        final Alignment center = Alignment(
          0.35 * math.cos(t * math.pi * 2),
          0.25 * math.sin(t * math.pi * 2),
        );
        final RadialGradient g = RadialGradient(
          center: center,
          radius: 0.55 + 0.35 * (0.5 + 0.5 * wave),
          colors: spec.colors,
          stops: spec.stops,
        );
        return darkScrimIfNeeded(
          context,
          DecoratedBox(
            decoration: BoxDecoration(gradient: g),
            child: const SizedBox.expand(),
          ),
        );
      },
    );
  }
}

class _AnimatedOrbitLinear extends _AnimatedGradientBase {
  const _AnimatedOrbitLinear({required super.spec});

  @override
  State<_AnimatedOrbitLinear> createState() => _AnimatedOrbitLinearState();
}

class _AnimatedOrbitLinearState
    extends _AnimatedGradientBaseState<_AnimatedOrbitLinear> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        final double a = _controller.value * math.pi * 2;
        final Alignment begin = Alignment(math.cos(a), math.sin(a));
        final Alignment end = Alignment(-math.cos(a), -math.sin(a));
        final LinearGradient g = LinearGradient(
          begin: begin,
          end: end,
          colors: spec.colors,
          stops: spec.stops,
        );
        return darkScrimIfNeeded(
          context,
          DecoratedBox(
            decoration: BoxDecoration(gradient: g),
            child: const SizedBox.expand(),
          ),
        );
      },
    );
  }
}

class _AnimatedColorOscillation extends _AnimatedGradientBase {
  const _AnimatedColorOscillation({required super.spec});

  @override
  State<_AnimatedColorOscillation> createState() =>
      _AnimatedColorOscillationState();
}

class _AnimatedColorOscillationState
    extends _AnimatedGradientBaseState<_AnimatedColorOscillation> {
  @override
  Widget build(BuildContext context) {
    final List<Color> alt = spec.altColors ?? spec.colors;
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        final double u = (math.sin(_controller.value * math.pi * 2) + 1) / 2;
        final List<Color> blended = List<Color>.generate(
          spec.colors.length,
          (int i) => Color.lerp(spec.colors[i], alt[i % alt.length], u)!,
        );
        final LinearGradient g = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: blended,
          stops: spec.stops,
        );
        return darkScrimIfNeeded(
          context,
          DecoratedBox(
            decoration: BoxDecoration(gradient: g),
            child: const SizedBox.expand(),
          ),
        );
      },
    );
  }
}

class _AnimatedShiftingStops extends _AnimatedGradientBase {
  const _AnimatedShiftingStops({required super.spec});

  @override
  State<_AnimatedShiftingStops> createState() =>
      _AnimatedShiftingStopsState();
}

class _AnimatedShiftingStopsState
    extends _AnimatedGradientBaseState<_AnimatedShiftingStops> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        final double t = _controller.value;
        final double m = 0.35 + 0.12 * math.sin(t * math.pi * 2);
        final double n = 0.62 + 0.1 * math.cos(t * math.pi * 2);
        double lo = math.min(m, n).clamp(0.12, 0.45);
        double hi = math.max(m, n).clamp(0.52, 0.88);
        if (hi <= lo + 0.06) {
          hi = (lo + 0.12).clamp(0.55, 0.92);
        }
        final List<double> stops = <double>[0, lo, hi, 1];
        final LinearGradient g = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: spec.colors,
          stops: stops,
        );
        return darkScrimIfNeeded(
          context,
          DecoratedBox(
            decoration: BoxDecoration(gradient: g),
            child: const SizedBox.expand(),
          ),
        );
      },
    );
  }
}

class _AnimatedSlowRotation extends _AnimatedGradientBase {
  const _AnimatedSlowRotation({required super.spec});

  @override
  State<_AnimatedSlowRotation> createState() => _AnimatedSlowRotationState();
}

class _AnimatedSlowRotationState
    extends _AnimatedGradientBaseState<_AnimatedSlowRotation> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        final double angle = (_controller.value - 0.5) * 0.55;
        return darkScrimIfNeeded(
          context,
          Transform.rotate(
            angle: angle,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: spec.colors,
                  stops: spec.stops,
                ),
              ),
              child: const SizedBox.expand(),
            ),
          ),
        );
      },
    );
  }
}

class _AnimatedWaveEndSweep extends _AnimatedGradientBase {
  const _AnimatedWaveEndSweep({required super.spec});

  @override
  State<_AnimatedWaveEndSweep> createState() =>
      _AnimatedWaveEndSweepState();
}

class _AnimatedWaveEndSweepState
    extends _AnimatedGradientBaseState<_AnimatedWaveEndSweep> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        final double t = Curves.easeInOut.transform(_controller.value);
        final Alignment end = Alignment.lerp(
          Alignment.bottomLeft,
          Alignment.bottomRight,
          t,
        )!;
        final LinearGradient g = LinearGradient(
          begin: Alignment.topCenter,
          end: end,
          colors: spec.colors,
          stops: spec.stops,
        );
        return darkScrimIfNeeded(
          context,
          DecoratedBox(
            decoration: BoxDecoration(gradient: g),
            child: const SizedBox.expand(),
          ),
        );
      },
    );
  }
}

class _AnimatedOrbitElliptic extends _AnimatedGradientBase {
  const _AnimatedOrbitElliptic({required super.spec});

  @override
  State<_AnimatedOrbitElliptic> createState() =>
      _AnimatedOrbitEllipticState();
}

class _AnimatedOrbitEllipticState
    extends _AnimatedGradientBaseState<_AnimatedOrbitElliptic> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        final double a = _controller.value * math.pi * 2;
        final Alignment begin = Alignment(
          0.88 * math.cos(a),
          0.42 * math.sin(2 * a),
        );
        const Alignment end = Alignment.bottomCenter;
        final LinearGradient g = LinearGradient(
          begin: begin,
          end: end,
          colors: spec.colors,
          stops: spec.stops,
        );
        return darkScrimIfNeeded(
          context,
          DecoratedBox(
            decoration: BoxDecoration(gradient: g),
            child: const SizedBox.expand(),
          ),
        );
      },
    );
  }
}
