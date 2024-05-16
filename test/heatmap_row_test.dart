import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vertical_heatmap/src/heatmap_cell.dart';
import 'package:flutter_vertical_heatmap/src/heatmap_row.dart';

void main() {
  group('HeatMapRow', () {
    testWidgets('displays the correct number of days',
        (WidgetTester tester) async {
      final startDate = DateTime(2024, 1, 1);
      const numDays = 7;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeatMapRow(
              startDate: startDate,
              numDays: numDays,
            ),
          ),
        ),
      );

      // Verify that the correct number of day cells are displayed
      final dayCells = find.byType(HeatMapCell);
      expect(dayCells, findsNWidgets(numDays));
    });

    testWidgets('displays month text', (WidgetTester tester) async {
      final startDate = DateTime(2023, 5, 1);
      const numDays = 7;
      const monthText = 'Jun';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeatMapRow(
              startDate: startDate,
              numDays: numDays,
              monthText: monthText,
            ),
          ),
        ),
      );

      // Verify that the month text is correctly displayed
      expect(find.text(monthText), findsOneWidget);
    });

    testWidgets('displays empty spaces for incomplete weeks',
        (WidgetTester tester) async {
      final startDate = DateTime(2024, 1, 1);
      const numDays = 5;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeatMapRow(
              startDate: startDate,
              numDays: numDays,
            ),
          ),
        ),
      );

      // Verify that the correct number of day cells are displayed
      final totalCells = find.byType(HeatMapCell);
      expect(totalCells, findsNWidgets(numDays));

      // Verify that the correct number of empty spaces are rendered
      final emptySpaces = find.descendant(
        of: find.byType(HeatMapRow),
        matching: find.byWidgetPredicate((widget) {
          return widget is Container &&
              widget.constraints?.maxWidth == 40 &&
              widget.constraints?.maxHeight == 40;
        }),
      );
      expect(emptySpaces, findsNWidgets(7 - numDays));
    });
  });
}
