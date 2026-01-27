import 'package:flutter/material.dart';
import 'package:colored_image/colored_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colored Image Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  Color selectedColor = Colors.blue;

  final List<Color> demoColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colored Image Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Color Tinting with Detail Preservation',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Select a color below to see how the package applies color tints while maintaining all image details.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Color selector
            const Text(
              'Select a Color:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: demoColors.map((color) {
                final isSelected = color == selectedColor;
                return GestureDetector(
                  onTap: () => setState(() => selectedColor = color),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.grey[300]!,
                        width: isSelected ? 3 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: color.withValues(alpha: 0.5),
                                blurRadius: 8,
                                spreadRadius: 2,
                              )
                            ]
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),

            // Demo section 1: Single icon
            const Text(
              'Example 1: Single Icon',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.favorite, size: 80, color: Colors.grey),
                        const SizedBox(height: 8),
                        const Text('Original'),
                      ],
                    ),
                    Column(
                      children: [
                        ColoredImage(
                          color: selectedColor,
                          child: Icon(Icons.favorite, size: 80, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        const Text('Colored'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Demo section 2: Multiple icons
            const Text(
              'Example 2: Multiple Icons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Text('Original Icons:', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.home, size: 50, color: Colors.grey),
                        Icon(Icons.star, size: 50, color: Colors.grey),
                        Icon(Icons.settings, size: 50, color: Colors.grey),
                        Icon(Icons.person, size: 50, color: Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text('Colored Icons:', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 12),
                    ColorTintFilter(
                      color: selectedColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.home, size: 50, color: Colors.grey),
                          Icon(Icons.star, size: 50, color: Colors.grey),
                          Icon(Icons.settings, size: 50, color: Colors.grey),
                          Icon(Icons.person, size: 50, color: Colors.grey),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Demo section 3: Complex gradients
            const Text(
              'Example 3: Gradient Shapes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [Colors.white, Colors.black],
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text('Original'),
                      ],
                    ),
                    Column(
                      children: [
                        ColorTintFilter(
                          color: selectedColor,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                colors: [Colors.white, Colors.black],
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text('Colored'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Demo section 4: Code example
            const Text(
              'Usage Example:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              color: Colors.grey[900],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      '''ColoredImage(
  color: Colors.${_getColorName(selectedColor)},
  child: Image.asset('icon.png'),
)''',
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        color: Colors.greenAccent,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Info card
            Card(
              elevation: 2,
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.blue[900]),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'This package preserves all image details by using luminance-based color matrix transformations.',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getColorName(Color color) {
    if (color == Colors.red) return 'red';
    if (color == Colors.pink) return 'pink';
    if (color == Colors.purple) return 'purple';
    if (color == Colors.deepPurple) return 'deepPurple';
    if (color == Colors.indigo) return 'indigo';
    if (color == Colors.blue) return 'blue';
    if (color == Colors.lightBlue) return 'lightBlue';
    if (color == Colors.cyan) return 'cyan';
    if (color == Colors.teal) return 'teal';
    if (color == Colors.green) return 'green';
    if (color == Colors.lightGreen) return 'lightGreen';
    if (color == Colors.lime) return 'lime';
    if (color == Colors.yellow) return 'yellow';
    if (color == Colors.amber) return 'amber';
    if (color == Colors.orange) return 'orange';
    if (color == Colors.deepOrange) return 'deepOrange';
    return 'blue';
  }
}
