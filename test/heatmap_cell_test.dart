import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vertical_heatmap/flutter_vertical_heatmap.dart';
import 'package:flutter_vertical_heatmap/src/heatmap_cell.dart';

void main() {
  testWidgets('HeatMapCell displays with default properties', (WidgetTester tester) async {
    final DateTime testDate = DateTime(2024, 1, 1);

    // Add HeatMapCell widget with default properties to the test environment
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeatMapCell(
            date: testDate,
          ),
        ),
      ),
    );

    // Verify that the widget is rendered correctly
    expect(find.byType(HeatMapCell), findsOneWidget);
    expect(find.byType(Container), findsNWidgets(2)); // Outer and inner containers
  });

  testWidgets('HeatMapCell calls onTap callback when tapped', (WidgetTester tester) async {
    final DateTime testDate = DateTime(2024, 1, 1);
    bool wasTapped = false;

    // Add HeatMapCell widget with onTap callback to the test environment
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeatMapCell(
            date: testDate,
            onTap: (date) {
              wasTapped = true;
              expect(date, testDate); // Verify the correct date is passed
            },
          ),
        ),
      ),
    );

    // Verify that the onTap callback is called when the HeatMapCell is tapped
    await tester.tap(find.byType(HeatMapCell));
    await tester.pump(); // Update the frame

    expect(wasTapped, isTrue); // Verify the callback was called
  });

  testWidgets('HeatMapCell displays with custom properties', (WidgetTester tester) async {
    final DateTime testDate = DateTime(2024, 1, 1);

    // Add HeatMapCell widget with custom properties to the test environment
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeatMapCell(
            date: testDate,
            size: 50.0,
            backgroundColor: Colors.red,
            selectedColor: Colors.blue,
            borderRadius: 8.0,
          ),
        ),
      ),
    );

    // Verify that the custom properties are applied correctly
    final outerContainer = tester.widget<Container>(find.byType(Container).first);
    final BoxDecoration outerDecoration = outerContainer.decoration as BoxDecoration;
    expect(outerDecoration.color, Colors.red);
    expect(outerDecoration.borderRadius, const BorderRadius.all(Radius.circular(8.0)));

    final innerContainer = tester.widget<Container>(find.byType(Container).last);
    final BoxDecoration innerDecoration = innerContainer.decoration as BoxDecoration;
    expect(innerDecoration.color, Colors.blue);
    expect(innerDecoration.borderRadius, const BorderRadius.all(Radius.circular(8.0)));
  });

  testWidgets('HeatMapCell displays with custom margin', (WidgetTester tester) async {
    final DateTime testDate = DateTime(2024, 1, 1);

    // Add HeatMapCell widget with custom margin to the test environment
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeatMapCell(
            date: testDate,
            margin: const EdgeInsets.all(10.0),
          ),
        ),
      ),
    );

    // Verify that the custom margin is applied correctly
    final padding = tester.widget<Padding>(find.byType(Padding).first).padding as EdgeInsets;
    expect(padding, const EdgeInsets.all(10.0));
  });

  testWidgets('HeatMapCell displays with null properties', (WidgetTester tester) async {
    final DateTime testDate = DateTime(2024, 1, 1);

    // Add HeatMapCell widget with null properties to the test environment
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeatMapCell(
            date: testDate,
            size: null,
            backgroundColor: null,
            selectedColor: null,
            borderRadius: null,
          ),
        ),
      ),
    );

    // Verify that the widget handles null properties correctly
    final outerContainer = tester.widget<Container>(find.byType(Container).first);
    final BoxDecoration outerDecoration = outerContainer.decoration as BoxDecoration;
    expect(outerDecoration.color, HeatMapDefault.surfaceColor); // Check default color
    expect(outerDecoration.borderRadius, const BorderRadius.all(Radius.circular(5))); // Check default border radius
  });
}