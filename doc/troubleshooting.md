# Troubleshooting Guide

This guide helps you resolve common issues when using the Colored Image package.

## Common Issues

### Issue: Colors appear washed out or too dim

**Symptoms:**
- Applied colors look less vibrant than expected
- Images appear faded

**Solutions:**

1. **Use brighter, more saturated colors:**
```dart
// Instead of
ColoredImage(color: Colors.grey[700]!, child: image)

// Try
ColoredImage(color: Colors.blue, child: image)
```

2. **Ensure your source image has good contrast:**
The package preserves the luminance structure of the original image. If your source image is low contrast or mostly uniform in brightness, the colorized result will maintain that characteristic.

3. **Adjust the source image:**
For best results, use images with:
- Good contrast between light and dark areas
- Clear details and edges
- Grayscale or monochrome originals work best

---

### Issue: Colors look different than expected

**Symptoms:**
- The applied color doesn't match the target color exactly
- Results look tinted differently than anticipated

**Explanation:**

The package uses a luminance-preserving color matrix that maintains the brightness structure of the original image. This means:
- The final color is a combination of the target color and the original luminance
- Areas that were darker in the original will remain darker
- Areas that were lighter will remain lighter

**This is by design** to preserve image details!

**Example:**
```dart
// Original image: grayscale icon with dark (20% brightness) and light (80% brightness) areas
// Target color: Blue

// Result:
// - Dark areas will be dark blue (preserving 20% brightness)
// - Light areas will be light blue (preserving 80% brightness)
```

---

### Issue: Image appears completely black or white

**Symptoms:**
- Colorized image shows no detail
- Output is solid color

**Possible Causes:**

1. **Using black color:**
```dart
// This will result in a black image (no light to preserve)
ColoredImage(color: Colors.black, child: image)
```

**Solution:** Use colors with RGB values above 0.

2. **Source image is completely uniform:**
If your source image has no variation in brightness, the result will also be uniform.

---

### Issue: Transparency is lost

**Symptoms:**
- Alpha channel appears incorrect
- Transparent areas become opaque

**Solution:**

The package preserves the alpha channel. If you're experiencing issues:

1. **Check the blend mode:**
```dart
ColoredImage(
  color: Colors.blue,
  blendMode: BlendMode.srcATop, // Default, preserves transparency
  child: image,
)
```

2. **Verify source image transparency:**
Ensure your source image actually has an alpha channel.

---

### Issue: Performance problems or lag

**Symptoms:**
- UI feels sluggish when using ColoredImage
- Frame drops during animations

**Solutions:**

1. **Cache the color matrix:**
```dart
class MyWidget extends StatelessWidget {
  // Cache the matrix as a class member if color doesn't change
  static final _blueMatrix = buildColorMatrix(Colors.blue);
  
  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.matrix(_blueMatrix),
      child: image,
    );
  }
}
```

2. **Use RepaintBoundary for static images:**
```dart
RepaintBoundary(
  child: ColoredImage(
    color: Colors.blue,
    child: image,
  ),
)
```

3. **Profile your app:**
Use Flutter DevTools to identify actual bottlenecks. The color filter itself is hardware-accelerated and should not cause performance issues.

---

### Issue: Build errors or compilation failures

**Symptoms:**
- Import errors
- Type errors
- Compilation fails

**Solutions:**

1. **Verify package installation:**
```bash
flutter pub get
flutter clean
flutter pub get
```

2. **Check minimum Flutter version:**
```yaml
# Your pubspec.yaml
environment:
  sdk: ^3.10.4
  flutter: ">=1.17.0"
```

3. **Verify imports:**
```dart
import 'package:colored_image/colored_image.dart';
import 'package:flutter/material.dart';
```

---

### Issue: Widget not updating when color changes

**Symptoms:**
- Changing the color prop doesn't update the displayed color
- Widget appears "stuck" on old color

**Solution:**

Ensure you're properly triggering rebuilds:

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Color selectedColor = Colors.blue;

  void changeColor(Color newColor) {
    setState(() {  // This triggers a rebuild
      selectedColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredImage(
      color: selectedColor,
      child: Image.asset('assets/icon.png'),
    );
  }
}
```

---

## Platform-Specific Issues

### iOS

**Issue:** Colors appear different on iOS vs Android

**Solution:** This is typically due to color space differences. Both platforms should produce very similar results, but minor variations are normal due to hardware rendering differences.

### Web

**Issue:** Performance issues on web

**Solution:** 
- Ensure you're using the CanvasKit renderer for better performance
- Run with: `flutter run -d chrome --web-renderer canvaskit`

### Desktop (macOS, Windows, Linux)

**Issue:** Inconsistent behavior on desktop

**Solution:** Desktop platforms fully support color filters. If you experience issues:
1. Update to the latest Flutter stable version
2. Run `flutter doctor` to ensure proper setup
3. Clear cache: `flutter clean`

---

## Debugging Tips

### 1. Verify the Color Matrix

Print the color matrix to ensure it's being generated correctly:

```dart
final matrix = buildColorMatrix(Colors.blue);
print('Color Matrix: $matrix');

// Expected: List of 20 doubles, positions [18] should be 1.0 (alpha preservation)
```

### 2. Test with Simple Colors

Start with pure colors to verify the package is working:

```dart
// Test with primary colors
ColoredImage(color: Color(0xFFFF0000), child: image) // Pure red
ColoredImage(color: Color(0xFF00FF00), child: image) // Pure green
ColoredImage(color: Color(0xFF0000FF), child: image) // Pure blue
```

### 3. Use Debug Paint

Enable debug painting to see widget boundaries:

```dart
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(MyApp());
}
```

### 4. Compare Side-by-Side

Create a comparison view:

```dart
Row(
  children: [
    // Original
    Expanded(child: Image.asset('assets/icon.png')),
    
    // Colored
    Expanded(
      child: ColoredImage(
        color: Colors.blue,
        child: Image.asset('assets/icon.png'),
      ),
    ),
  ],
)
```

---

## Getting Help

If you've tried the solutions above and still have issues:

1. **Check existing issues:** Visit [GitHub Issues](https://github.com/yourusername/colored_image/issues)
2. **Create a new issue** with:
   - Flutter version (`flutter --version`)
   - Package version
   - Minimal code to reproduce the issue
   - Screenshots if applicable
   - Expected vs actual behavior

3. **Provide a reproducible example:**
```dart
import 'package:flutter/material.dart';
import 'package:colored_image/colored_image.dart';

void main() => runApp(
  MaterialApp(
    home: Scaffold(
      body: Center(
        child: ColoredImage(
          color: Colors.blue,
          child: Icon(Icons.star, size: 100, color: Colors.grey),
        ),
      ),
    ),
  ),
);
```

---

## Best Practices to Avoid Issues

1. **Use appropriate source images:**
   - High contrast images work best
   - Grayscale or monochrome sources are ideal
   - Ensure images have details to preserve

2. **Choose vibrant colors:**
   - Saturated colors produce better results
   - Avoid very dark or very light colors

3. **Test on multiple platforms:**
   - Verify behavior on all target platforms
   - Check both debug and release builds

4. **Profile performance:**
   - Use Flutter DevTools
   - Measure frame times
   - Identify actual bottlenecks before optimizing

5. **Keep the package updated:**
   - Check for updates regularly
   - Review CHANGELOG.md for breaking changes
   - Update dependencies: `flutter pub upgrade`
