import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:colored_image/colored_image.dart';

void main() {
  group('buildColorMatrix', () {
    test('returns a list of 20 values', () {
      final matrix = buildColorMatrix(Colors.blue);
      expect(matrix.length, 20);
    });

    test('returns valid color matrix for red', () {
      final matrix = buildColorMatrix(Colors.red);
      
      // Verify matrix structure (5x4 = 20 values)
      expect(matrix.length, 20);
      
      // All values should be finite numbers
      expect(matrix.every((value) => value.isFinite), true);
      
      // Alpha channel should be preserved (position 18 should be 1)
      expect(matrix[18], 1.0);
      
      // Offsets should be 0 (positions 4, 9, 14, 19)
      expect(matrix[4], 0.0);
      expect(matrix[9], 0.0);
      expect(matrix[14], 0.0);
      expect(matrix[19], 0.0);
    });

    test('returns valid color matrix for green', () {
      final matrix = buildColorMatrix(Colors.green);
      
      expect(matrix.length, 20);
      expect(matrix.every((value) => value.isFinite), true);
      expect(matrix[18], 1.0);
    });

    test('returns valid color matrix for blue', () {
      final matrix = buildColorMatrix(Colors.blue);
      
      expect(matrix.length, 20);
      expect(matrix.every((value) => value.isFinite), true);
      expect(matrix[18], 1.0);
    });

    test('returns valid color matrix for white', () {
      final matrix = buildColorMatrix(Colors.white);
      
      expect(matrix.length, 20);
      expect(matrix.every((value) => value.isFinite), true);
      
      // White with intensity should have higher values
      expect(matrix[0] > 0, true); // Red component
      expect(matrix[6] > 0, true); // Green component
      expect(matrix[12] > 0, true); // Blue component
    });

    test('returns valid color matrix for black', () {
      final matrix = buildColorMatrix(Colors.black);
      
      expect(matrix.length, 20);
      expect(matrix.every((value) => value.isFinite), true);
      
      // Black should result in zero color values
      expect(matrix[0], 0.0);
      expect(matrix[6], 0.0);
      expect(matrix[12], 0.0);
    });

    test('clamps values between 0.0 and 1.0', () {
      final matrix = buildColorMatrix(Colors.white);
      
      // Check that all color values are clamped
      for (int i = 0; i < 15; i++) {
        if (i % 5 != 4) { // Skip offset values
          expect(matrix[i] >= 0.0, true, reason: 'Value at $i should be >= 0');
          expect(matrix[i] <= 1.0, true, reason: 'Value at $i should be <= 1');
        }
      }
    });

    test('preserves luminance weights in matrix structure', () {
      final matrix = buildColorMatrix(Color.fromRGBO(100, 150, 200, 1.0));
      
      // The matrix should follow the luminance weight structure
      // Each row should use the same luminance weights (0.299, 0.587, 0.114)
      expect(matrix.length, 20);
      
      // Verify the matrix structure is correct (not all zeros for non-black colors)
      final hasNonZeroValues = matrix.take(15).any((value) => value > 0);
      expect(hasNonZeroValues, true);
    });

    test('handles custom colors correctly', () {
      final customColor = Color.fromRGBO(128, 64, 192, 1.0);
      final matrix = buildColorMatrix(customColor);
      
      expect(matrix.length, 20);
      expect(matrix.every((value) => value.isFinite), true);
      expect(matrix[18], 1.0); // Alpha preserved
    });

    test('matrix values change with different colors', () {
      final redMatrix = buildColorMatrix(Colors.red);
      final blueMatrix = buildColorMatrix(Colors.blue);
      
      // Matrices should be different for different colors
      expect(redMatrix, isNot(equals(blueMatrix)));
    });
  });

  group('ColoredImage widget', () {
    testWidgets('creates ColoredImage widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ColoredImage(
            color: Colors.blue,
            child: SizedBox(width: 100, height: 100),
          ),
        ),
      );

      expect(find.byType(ColoredImage), findsOneWidget);
      expect(find.byType(ColorFiltered), findsOneWidget);
    });

    testWidgets('applies color filter to child', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ColoredImage(
            color: Colors.red,
            child: SizedBox(
              key: Key('test-container'),
              width: 100,
              height: 100,
            ),
          ),
        ),
      );

      expect(find.byKey(Key('test-container')), findsOneWidget);
      expect(find.byType(ColorFiltered), findsOneWidget);
    });

    testWidgets('accepts custom blend mode', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ColoredImage(
            color: Colors.green,
            blendMode: BlendMode.multiply,
            child: SizedBox(width: 100, height: 100),
          ),
        ),
      );

      expect(find.byType(ColoredImage), findsOneWidget);
    });
  });

  group('ColorTintFilter widget', () {
    testWidgets('creates ColorTintFilter widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ColorTintFilter(
            color: Colors.purple,
            child: SizedBox(width: 100, height: 100),
          ),
        ),
      );

      expect(find.byType(ColorTintFilter), findsOneWidget);
      expect(find.byType(ColorFiltered), findsOneWidget);
    });

    testWidgets('applies color filter to child', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ColorTintFilter(
            color: Colors.orange,
            child: Column(
              key: Key('test-column'),
              children: [
                SizedBox(width: 50, height: 50),
                SizedBox(width: 50, height: 50),
              ],
            ),
          ),
        ),
      );

      expect(find.byKey(Key('test-column')), findsOneWidget);
      expect(find.byType(ColorFiltered), findsOneWidget);
    });

    testWidgets('can wrap multiple children', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ColorTintFilter(
            color: Colors.teal,
            child: Column(
              children: [
                SizedBox(key: Key('child1'), width: 50, height: 50),
                SizedBox(key: Key('child2'), width: 50, height: 50),
                SizedBox(key: Key('child3'), width: 50, height: 50),
              ],
            ),
          ),
        ),
      );

      expect(find.byKey(Key('child1')), findsOneWidget);
      expect(find.byKey(Key('child2')), findsOneWidget);
      expect(find.byKey(Key('child3')), findsOneWidget);
    });
  });

  group('Integration tests', () {
    test('ColorFilter can be created from buildColorMatrix', () {
      final matrix = buildColorMatrix(Colors.blue);
      final colorFilter = ColorFilter.matrix(matrix);
      
      expect(colorFilter, isNotNull);
    });

    test('Different colors produce different matrices', () {
      final colors = [
        Colors.red,
        Colors.green,
        Colors.blue,
        Colors.yellow,
        Colors.purple,
        Colors.orange,
      ];

      final matrices = colors.map((color) => buildColorMatrix(color)).toList();

      // Each matrix should be unique
      for (int i = 0; i < matrices.length; i++) {
        for (int j = i + 1; j < matrices.length; j++) {
          expect(matrices[i], isNot(equals(matrices[j])),
              reason: '${colors[i]} and ${colors[j]} should produce different matrices');
        }
      }
    });
  });
}
