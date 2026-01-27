# Colored Image Example

This example demonstrates how to use the `colored_image` package to apply color tints to images and icons while preserving all details.

## Running the Example

1. Navigate to the example directory:
```bash
cd example
```

2. Get dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## What's Demonstrated

The example app shows:

1. **Single Icon Coloring** - Apply color tints to individual icons
2. **Multiple Icons** - Use `ColorTintFilter` to color multiple widgets at once
3. **Gradient Shapes** - See how the package preserves gradients and details
4. **Interactive Color Selection** - Choose from 16 different colors to see real-time changes
5. **Code Examples** - View the actual code used for each demonstration

## Key Features Shown

- Using `ColoredImage` widget for single images
- Using `ColorTintFilter` for multiple child widgets
- How colors are preserved while maintaining detail
- Real-time color changes with interactive UI

## Learning Points

- The package maintains luminance information from the original image
- Works with any Flutter widget (Icons, Images, Containers with gradients, etc.)
- Performance is excellent due to hardware-accelerated color matrix transformations
- Easy to integrate into existing Flutter applications
