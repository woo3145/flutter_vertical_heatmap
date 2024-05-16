import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vertical_heatmap/src/heatmap_color_tip.dart';

void main() {
  group('HeatMapColorTip', () {
    testWidgets('does not render color tips when colorTipSize is null', (WidgetTester tester) async {
      final colorsets = {1: Colors.red, 2: Colors.green, 3: Colors.blue};

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeatMapColorTip(
              colorsets: colorsets,
              colorTipSize: null,
            ),
          ),
        ),
      );

      // Verify that no color tips are rendered
      final colorTips = find.byType(Container);
      expect(colorTips, findsNothing);
    });

    testWidgets('renders color tips when colorTipSize is provided', (WidgetTester tester) async {
      final colorsets = {1: Colors.red, 2: Colors.green, 3: Colors.blue};
      const colorTipSize = 20.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeatMapColorTip(
              colorsets: colorsets,
              colorTipSize: colorTipSize,
            ),
          ),
        ),
      );

      // Verify that the correct number of color tips are rendered
      final colorTips = find.byType(Container);
      expect(colorTips, findsNWidgets(colorsets.length));
    });

    testWidgets('displays the correct number of color tips',
        (WidgetTester tester) async {
      final colorsets = {1: Colors.red, 2: Colors.green, 3: Colors.blue};
      const colorTipSize = 30.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeatMapColorTip(
              colorsets: colorsets,
              colorTipSize: colorTipSize,
            ),
          ),
        ),
      );

      // Verify that the correct number of color tips are displayed
      final colorTips = find.byType(Container);
      expect(colorTips, findsNWidgets(colorsets.length));
    });

    testWidgets('displays custom color tip labels',
        (WidgetTester tester) async {
      final colorsets = {1: Colors.red, 2: Colors.green, 3: Colors.blue};
      final colorTipLabels = ['Low', 'Medium', 'High'];
      const colorTipSize = 30.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeatMapColorTip(
              colorsets: colorsets,
              colorTipLabel: colorTipLabels,
              colorTipSize: colorTipSize,
            ),
          ),
        ),
      );

      // Verify that the custom color tip labels are displayed
      for (String label in colorTipLabels) {
        expect(find.text(label), findsOneWidget);
      }
    });

    testWidgets('applies custom color tip size', (WidgetTester tester) async {
      final colorsets = {1: Colors.red, 2: Colors.green, 3: Colors.blue};
      const colorTipSize = 30.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeatMapColorTip(
              colorsets: colorsets,
              colorTipSize: colorTipSize,
            ),
          ),
        ),
      );

      // Verify that the color tip size is applied correctly
      final containerWidgets =
          tester.widgetList<Container>(find.byType(Container));
      for (Container containerWidget in containerWidgets) {
        expect(containerWidget.constraints?.maxWidth, colorTipSize);
        expect(containerWidget.constraints?.maxHeight, colorTipSize);
      }
    });

    testWidgets('correctly displays blank space on the right with custom size',
        (WidgetTester tester) async {
      final colorsets = {1: Colors.red, 2: Colors.green, 3: Colors.blue};
      const size = 50.0;
      const colorTipSize = 30.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeatMapColorTip(
              colorsets: colorsets,
              size: size,
              colorTipSize: colorTipSize,
            ),
          ),
        ),
      );

      // Verify that the size is applied correctly
      final sizedBox = find.byType(SizedBox).evaluate().last.widget as SizedBox;
      expect(sizedBox.width, size);
    });
  });
}
