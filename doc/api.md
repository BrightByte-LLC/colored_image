# API Reference

## Functions

### `buildColorMatrix(Color color)`

Builds a color matrix for applying a color tint to an image while preserving its details and luminance information.

**Signature:**
```dart
List<double> buildColorMatrix(Color color)
```

**Parameters:**
- `color` (`Color`, required): The target color to apply to the image

**Returns:**
- `List<double>`: A list of 20 doubles representing a 5x4 color matrix that can be used with `ColorFilter.matrix()`

**Example:**
```dart
final matrix = buildColorMatrix(Colors.blue);
final colorFilter = ColorFilter.matrix(matrix);

// Use in a Paint object
final paint = Paint()..colorFilter = colorFilter;
```

**Technical Details:**

The function uses the following approach:
1. Extracts RGB values from the color and normalizes them to 0.0-1.0 range
2. Applies an intensity multiplier of 1.8 for more vivid colors
3. Multiplies each channel by standard luminance weights:
   - Red: 0.299
   - Green: 0.587
   - Blue: 0.114
4. Returns a 5x4 matrix in the format expected by `ColorFilter.matrix()`

The resulting matrix maintains the luminance structure of the original image while applying the target color, ensuring all details are preserved.

---

## Widgets

### `ColoredImage`

A widget that applies a color tint to its child image while preserving details.

**Signature:**
```dart
class ColoredImage extends StatelessWidget {
  const ColoredImage({
    Key? key,
    required this.color,
    required this.child,
    this.blendMode = BlendMode.srcATop,
  });
}
```

**Properties:**

- `color` (`Color`, required): The color to apply to the child image
- `child` (`Widget`, required): The image widget to be colored
- `blendMode` (`BlendMode`, optional): The blend mode to use. Defaults to `BlendMode.srcATop`

**Example:**
```dart
ColoredImage(
  color: Colors.purple,
  child: Image.asset('assets/icon.png'),
)
```

**Use Cases:**
- Dynamic icon theming
- Applying brand colors to images
- Creating color variations without duplicating assets

---

### `ColorTintFilter`

A widget that applies a color tint to any child widget tree while preserving details.

**Signature:**
```dart
class ColorTintFilter extends StatelessWidget {
  const ColorTintFilter({
    Key? key,
    required this.color,
    required this.child,
  });
}
```

**Properties:**

- `color` (`Color`, required): The color to apply as a tint
- `child` (`Widget`, required): The widget to apply the color tint to

**Example:**
```dart
ColorTintFilter(
  color: Colors.teal,
  child: Column(
    children: [
      Image.asset('assets/image1.png'),
      Image.asset('assets/image2.png'),
      Icon(Icons.star, size: 50),
    ],
  ),
)
```

**Use Cases:**
- Applying consistent color themes to multiple widgets
- Dynamic theme switching
- Creating color-coordinated layouts

---

## Color Matrix Format

The color matrix returned by `buildColorMatrix()` follows the standard 5x4 format used by `ColorFilter.matrix()`:

```
[
  // Red output channel
  R_R, R_G, R_B, R_A, R_offset,
  
  // Green output channel
  G_R, G_G, G_B, G_A, G_offset,
  
  // Blue output channel
  B_R, B_G, B_B, B_A, B_offset,
  
  // Alpha output channel
  A_R, A_G, A_B, A_A, A_offset,
]
```

Where:
- First 4 values in each row are multiplication factors for R, G, B, A input channels
- Last value in each row is an offset added to the output

For our implementation:
- Each color channel is multiplied by the luminance weights and the target color component
- Alpha channel is preserved (identity transformation: 0, 0, 0, 1, 0)
- All offsets are 0

---

## Performance Considerations

### Efficiency
- Color matrix transformations are hardware-accelerated on most platforms
- Matrix calculation happens only once when the color changes
- No runtime image processing or pixel manipulation required

### Best Practices
- Reuse color matrices when possible (store them if using the same color multiple times)
- Use `const` constructors when colors are compile-time constants
- Prefer `ColoredImage` for single images and `ColorTintFilter` for widget trees

### Benchmarks
On modern devices:
- Matrix calculation: < 0.1ms
- Filter application: Hardware-accelerated (no measurable overhead)
- Suitable for animations and real-time theme changes

---

## Advanced Usage

### Custom Color Filters

You can combine the color matrix with other transformations:

```dart
final colorMatrix = buildColorMatrix(Colors.blue);
final customMatrix = List<double>.from(colorMatrix);

// Adjust brightness by modifying offsets
customMatrix[4] = 20;  // Red offset
customMatrix[9] = 20;  // Green offset
customMatrix[14] = 20; // Blue offset

final filter = ColorFilter.matrix(customMatrix);
```

### Animation Example

```dart
class AnimatedColoredImage extends StatefulWidget {
  @override
  _AnimatedColoredImageState createState() => _AnimatedColoredImageState();
}

class _AnimatedColoredImageState extends State<AnimatedColoredImage>
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
          color: _colorAnimation.value ?? Colors.blue,
          child: Image.asset('assets/icon.png'),
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

### Theme Integration

```dart
class ThemedIcon extends StatelessWidget {
  final String assetPath;

  const ThemedIcon({required this.assetPath});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    
    return ColoredImage(
      color: primaryColor,
      child: Image.asset(assetPath),
    );
  }
}
```
