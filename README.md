# Colored Image

[![pub package](https://img.shields.io/pub/v/colored_image.svg)](https://pub.dev/packages/colored_image)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A Flutter package for applying color tints to images while **preserving all details and luminance information**. Unlike simple color filters that can wash out details, this package uses advanced color matrix transformations to maintain the original image's brightness and detail structure.

## Features

- 🎨 **Detail-Preserving Colorization** - Maintains luminance and image details while applying color tints
- 🚀 **High Performance** - Uses efficient color matrix transformations
- 🎯 **Easy to Use** - Simple widgets and functions with sensible defaults
- 🔧 **Flexible** - Works with any color and supports custom intensity
- 📦 **Zero Dependencies** - Only depends on Flutter SDK
- ♿ **Accessible** - Works seamlessly with Flutter's widget system

## Use Cases

- Dynamic icon theming
- Applying brand colors to monochrome images
- Creating color variations of the same image
- Implementing dark/light theme variations
- UI element colorization without losing detail

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  colored_image: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Simple Image Coloring

Use the `ColoredImage` widget to apply a color tint to an image:

```dart
import 'package:colored_image/colored_image.dart';
import 'package:flutter/material.dart';

ColoredImage(
  color: Colors.blue,
  child: Image.asset('assets/icon.png'),
)
```

### Color Multiple Widgets

Use `ColorTintFilter` to apply color tints to complex widget trees:

```dart
ColorTintFilter(
  color: Colors.purple,
  child: Column(
    children: [
      Image.asset('assets/image1.png'),
      Image.asset('assets/image2.png'),
    ],
  ),
)
```

### Using the Color Matrix Function

For advanced use cases, you can use the `buildColorMatrix` function directly:

```dart
final matrix = buildColorMatrix(Colors.red);
final colorFilter = ColorFilter.matrix(matrix);

// Use with ColorFiltered widget
ColorFiltered(
  colorFilter: colorFilter,
  child: yourWidget,
)

// Or with Paint for custom rendering
final paint = Paint()
  ..colorFilter = colorFilter;
```

### Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:colored_image/colored_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Colored Image Demo')),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Original image
              Image.asset('assets/icon.png', width: 100),
              
              // Blue tinted
              ColoredImage(
                color: Colors.blue,
                child: Image.asset('assets/icon.png', width: 100),
              ),
              
              // Red tinted
              ColoredImage(
                color: Colors.red,
                child: Image.asset('assets/icon.png', width: 100),
              ),
              
              // Green tinted
              ColoredImage(
                color: Colors.green,
                child: Image.asset('assets/icon.png', width: 100),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## How It Works

The package uses a color matrix transformation that:

1. Extracts the luminance (brightness) information from the original image
2. Applies the target color while preserving the luminance structure
3. Uses standard perceptual luminance weights (R: 0.299, G: 0.587, B: 0.114)
4. Applies an intensity multiplier (1.8x) for vivid colors

This approach ensures that all the detail and depth in the original image is maintained, unlike simple overlay or multiply blend modes that can flatten or wash out details.

## API Reference

### `buildColorMatrix(Color color)`

Builds a color matrix for applying a color tint to an image.

**Parameters:**
- `color`: The target color to apply to the image

**Returns:** `List<double>` - A 5x4 color matrix (20 values)

### `ColoredImage`

A widget that applies a color tint to its child image.

**Properties:**
- `color` (required): The color to apply to the child image
- `child` (required): The image widget to be colored
- `blendMode`: The blend mode to use (default: `BlendMode.srcATop`)

### `ColorTintFilter`

A widget that applies a color tint to any child widget.

**Properties:**
- `color` (required): The color to apply as a tint
- `child` (required): The widget to apply the color tint to

## Performance Considerations

- Color matrix transformations are hardware-accelerated on most platforms
- The matrix calculation is lightweight and happens only once per color change
- No image decoding or processing is required at runtime
- Suitable for use in animations and dynamic theming

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you find this package helpful, please give it a ⭐ on [GitHub](https://github.com/yourusername/colored_image)!

For issues, feature requests, or questions, please [open an issue](https://github.com/yourusername/colored_image/issues).
