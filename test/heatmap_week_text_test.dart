import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vertical_heatmap/src/heatmap_constants.dart';
import 'package:flutter_vertical_heatmap/src/heatmap_week_text.dart';

void main() {
  group('HeatMapWeekText', () {
    testWidgets('displays the default week labels', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeatMapWeekText(),
          ),
        ),
      );

      // Verify that the default week labels are displayed
      for (String label in HeatMapDefault.weekLabel) {
        expect(find.text(label), findsOneWidget);
      }
    });

    testWidgets('displays custom week labels', (WidgetTester tester) async {
      final customWeekLabels = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeatMapWeekText(
              weekLabel: customWeekLabels,
            ),
          ),
        ),
      );

      // Verify that the custom week labels are displayed
      for (String label in customWeekLabels) {
        expect(find.text(label), findsOneWidget);
      }
    });

    testWidgets('applies custom font size and color', (WidgetTester tester) async {
      const fontSize = 14.0;
      const fontColor = Colors.green;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeatMapWeekText(
              fontSize: fontSize,
              fontColor: fontColor,
            ),
          ),
        ),
      );

      // Verify that the text style is applied correctly
      final textWidgets = tester.widgetList<Text>(find.byType(Text));
      for (Text textWidget in textWidgets) {
        expect(textWidget.style?.fontSize, fontSize);
        expect(textWidget.style?.color, anyOf(Colors.red, Colors.blue, fontColor));
      }
    });

    testWidgets('applies custom margin and size', (WidgetTester tester) async {
      const margin = EdgeInsets.all(4.0);
      const size = 50.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: HeatMapWeekText(
              margin: margin,
              size: size,
            ),
          ),
        ),
      );

      // Verify that the container margin and size are applied correctly
      final containerWidgets = tester.widgetList<Container>(find.byType(Container));
      for (Container containerWidget in containerWidgets) {
        expect(containerWidget.margin, margin);
        expect(containerWidget.constraints?.maxWidth, size);
      }
    });
  });
}
