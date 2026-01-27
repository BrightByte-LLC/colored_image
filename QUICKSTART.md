# Quick Start Guide

Get up and running with Advanced Image Color in 5 minutes!

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  advanced_image_color: ^1.0.0
```

Run:

```bash
flutter pub get
```

## Basic Usage

### 1. Import the Package

```dart
import 'package:flutter/material.dart';
import 'package:advanced_image_color/advanced_image_color.dart';
```

### 2. Color a Single Image

```dart
ColoredImage(
  color: Colors.blue,
  child: Image.asset('assets/icon.png'),
)
```

### 3. Color Multiple Widgets

```dart
ColorTintFilter(
  color: Colors.purple,
  child: Column(
    children: [
      Image.asset('assets/image1.png'),
      Icon(Icons.star, size: 50),
      Image.asset('assets/image2.png'),
    ],
  ),
)
```

## Complete Example

Create a new Flutter app and replace `lib/main.dart` with:

```dart
import 'package:flutter/material.dart';
import 'package:advanced_image_color/advanced_image_color.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color selectedColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Advanced Image Color Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display colored icon
              ColoredImage(
                color: selectedColor,
                child: Icon(
                  Icons.favorite,
                  size: 150,
                  color: Colors.grey,
                ),
              ),
              
              SizedBox(height: 40),
              
              // Color selector buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildColorButton(Colors.red),
                  SizedBox(width: 10),
                  _buildColorButton(Colors.blue),
                  SizedBox(width: 10),
                  _buildColorButton(Colors.green),
                  SizedBox(width: 10),
                  _buildColorButton(Colors.purple),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorButton(Color color) {
    return GestureDetector(
      onTap: () => setState(() => selectedColor = color),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selectedColor == color ? Colors.black : Colors.grey,
            width: selectedColor == color ? 3 : 1,
          ),
        ),
      ),
    );
  }
}
```

Run it:

```bash
flutter run
```

## Common Use Cases

### Dynamic Theme Colors

```dart
class ThemedIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredImage(
      color: Theme.of(context).primaryColor,
      child: Image.asset('assets/icon.png'),
    );
  }
}
```

### Animated Color Changes

```dart
class AnimatedColorIcon extends StatefulWidget {
  @override
  _AnimatedColorIconState createState() => _AnimatedColorIconState();
}

class _AnimatedColorIconState extends State<AnimatedColorIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return ColoredImage(
          color: _colorAnimation.value!,
          child: Icon(Icons.star, size: 100, color: Colors.grey),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### Brand Color Icons

```dart
class BrandIcon extends StatelessWidget {
  static const brandColor = Color(0xFF1976D2); // Your brand color

  @override
  Widget build(BuildContext context) {
    return ColoredImage(
      color: brandColor,
      child: Image.asset('assets/logo.png'),
    );
  }
}
```

### Color Palette Previews

```dart
class ColorPalette extends StatelessWidget {
  final List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: colors.map((color) {
        return ColoredImage(
          color: color,
          child: Icon(Icons.circle, size: 50, color: Colors.grey),
        );
      }).toList(),
    );
  }
}
```

## Advanced Usage

### Using the Color Matrix Directly

```dart
final matrix = buildColorMatrix(Colors.blue);
final colorFilter = ColorFilter.matrix(matrix);

// Use with Paint
final paint = Paint()..colorFilter = colorFilter;

// Use with ColorFiltered widget
ColorFiltered(
  colorFilter: colorFilter,
  child: yourWidget,
)
```

### Custom Blend Modes

```dart
ColoredImage(
  color: Colors.blue,
  blendMode: BlendMode.multiply, // Try different blend modes
  child: Image.asset('assets/image.png'),
)
```

## Tips for Best Results

1. **Use high-contrast source images** - Images with clear light and dark areas produce the best results

2. **Choose saturated colors** - Bright, vivid colors work better than pale or dark colors

3. **Start with grayscale** - Grayscale or monochrome source images are ideal

4. **Test different colors** - Experiment with various colors to find what works best for your use case

## Performance Tips

1. **Cache matrices when possible:**
```dart
class MyWidget extends StatelessWidget {
  static final _blueMatrix = buildColorMatrix(Colors.blue);
  // Reuse _blueMatrix instead of recalculating
}
```

2. **Use const constructors:**
```dart
const ColoredImage(
  color: Colors.blue, // Compile-time constant
  child: Icon(Icons.star),
)
```

3. **Wrap with RepaintBoundary for complex widgets:**
```dart
RepaintBoundary(
  child: ColoredImage(
    color: Colors.blue,
    child: complexWidget,
  ),
)
```

## Next Steps

- Read the [API Documentation](doc/api.md) for detailed information
- Check the [Troubleshooting Guide](doc/troubleshooting.md) if you encounter issues
- Explore the [Example App](example/) for more complex use cases
- Visit the [GitHub Repository](https://github.com/yourusername/advanced_image_color) to contribute

## Need Help?

- [GitHub Issues](https://github.com/yourusername/advanced_image_color/issues)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter) with tag `advanced-image-color`
- [Flutter Community](https://flutter.dev/community)

---

That's it! You're now ready to use Advanced Image Color in your Flutter apps. Happy coding! 🎨
