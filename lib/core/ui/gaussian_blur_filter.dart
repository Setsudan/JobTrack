import 'dart:ui' show ImageFilter, TileMode;

/// Returns Flutter's standard **separable Gaussian blur** ([ImageFilter.blur]).
///
/// `sigmaX` / `sigmaY` are the Gaussian standard deviation in logical pixels, as
/// documented for [ImageFilter.blur]. The engine (Skia or Impeller) implements
/// this as a Gaussian kernel, not a box or median filter.
ImageFilter gaussianBlurFilter({
  required double sigmaX,
  required double sigmaY,
  TileMode tileMode = TileMode.clamp,
}) {
  return ImageFilter.blur(
    sigmaX: sigmaX,
    sigmaY: sigmaY,
    tileMode: tileMode,
  );
}
