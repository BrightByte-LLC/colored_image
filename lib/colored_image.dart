/// A Flutter package for applying color tints to images while preserving detail.
///
/// This library provides utilities to colorize images using color matrix
/// transformations that maintain the original image's luminance and detail.
library;

import 'package:flutter/widgets.dart';

/// Builds a color matrix for applying a color tint while preserving image details.
///
/// Creates a 5x4 color matrix (20 values) that can be used with [ColorFilter.matrix].
/// The matrix preserves luminance while applying the specified color.
///
/// Example:
/// ```dart
/// final matrix = buildColorMatrix(Colors.blue);
/// final colorFilter = ColorFilter.matrix(matrix);
/// ```
List<double> buildColorMatrix(Color color) {
  // Luminance weights for RGB
  const luminanceR = 0.299;
  const luminanceG = 0.587;
  const luminanceB = 0.114;
  const intensity = 1.8;

  final r = ((color.r * 255.0).round().clamp(0, 255) / 255 * intensity).clamp(0.0, 1.0);
  final g = ((color.g * 255.0).round().clamp(0, 255) / 255 * intensity).clamp(0.0, 1.0);
  final b = ((color.b * 255.0).round().clamp(0, 255) / 255 * intensity).clamp(0.0, 1.0);

  return [
    luminanceR * r, luminanceG * r, luminanceB * r, 0, 0,
    luminanceR * g, luminanceG * g, luminanceB * g, 0, 0,
    luminanceR * b, luminanceG * b, luminanceB * b, 0, 0,
    0, 0, 0, 1, 0,
  ];
}

/// Applies a color tint to an image while preserving details.
///
/// Useful for applying brand colors or theme colors to monochrome images.
///
/// Example:
/// ```dart
/// ColoredImage(
///   color: Colors.blue,
///   child: Image.asset('assets/icon.png'),
/// )
/// ```
class ColoredImage extends StatelessWidget {
  /// Creates a colored image widget.
  const ColoredImage({
    super.key,
    required this.color,
    required this.child,
    this.blendMode = BlendMode.srcATop,
  });

  /// The color to apply to the child image.
  final Color color;

  /// The image widget to be colored.
  final Widget child;

  /// The blend mode to use. Defaults to [BlendMode.srcATop].
  final BlendMode blendMode;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.matrix(buildColorMatrix(color)),
      child: child,
    );
  }
}

/// Applies a color tint to any widget while preserving details.
///
/// Can be used with any child widget, not just images.
///
/// Example:
/// ```dart
/// ColorTintFilter(
///   color: Colors.purple,
///   child: Column(
///     children: [
///       Image.asset('assets/image1.png'),
///       Image.asset('assets/image2.png'),
///     ],
///   ),
/// )
/// ```
class ColorTintFilter extends StatelessWidget {
  /// Creates a color tint filter widget.
  const ColorTintFilter({
    super.key,
    required this.color,
    required this.child,
  });

  /// The color to apply as a tint.
  final Color color;

  /// The widget to apply the color tint to.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.matrix(buildColorMatrix(color)),
      child: child,
    );
  }
}
