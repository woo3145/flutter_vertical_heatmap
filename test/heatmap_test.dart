import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vertical_heatmap/src/heatmap.dart';
import 'package:flutter_vertical_heatmap/src/heatmap_cell.dart';
import 'package:flutter_vertical_heatmap/src/heatmap_color_tip.dart';
import 'package:flutter_vertical_heatmap/src/heatmap_row.dart';
import 'package:flutter_vertical_heatmap/src/heatmap_week_text.dart';

void main() {
  group('HeatMap', () {
    testWidgets(
        'displays HeatMapColorTip, HeatMapWeekText, and HeatMapRow widgets',
        (WidgetTester tester) async {
      final startDate = DateTime(2024, 1, 1);
      final endDate = DateTime(2024, 1, 31);
      final colorsets = {1: Colors.red, 2: Colors.green, 3: Colors.blue};

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeatMap(
              startDate: startDate,
              endDate: endDate,
              colorsets: colorsets,
            ),
          ),
        ),
      );

      // Verify that HeatMapColorTip is displayed
      expect(find.byType(HeatMapColorTip), findsOneWidget);

      // Verify that HeatMapWeekText is displayed
      expect(find.byType(HeatMapWeekText), findsOneWidget);

      // Verify that HeatMapRow widgets are displayed
      final int numberOfWeeks =
          (endDate.difference(startDate).inDays / 7).ceil();
      expect(find.byType(HeatMapRow), findsNWidgets(numberOfWeeks));
    });

    testWidgets('displays custom labels and size', (WidgetTester tester) async {
      final startDate = DateTime(2024, 1, 1);
      final endDate = DateTime(2024, 12, 21);
      final colorsets = {1: Colors.red, 2: Colors.green, 3: Colors.blue};
      final customWeekLabels = [
        'Sun',
        'Mon',
        'Tue',
        'Wed',
        'Thu',
        'Fri',
        'Sat'
      ];
      const customMonthLabels = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      const customColorTipLabels = ['Low', 'Medium', 'High'];
      const customSize = 50.0;
      const colorTipSize = 30.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: HeatMap(
                startDate: startDate,
                endDate: endDate,
                colorsets: colorsets,
                size: customSize,
                colorTipSize: colorTipSize,
                weekLabel: customWeekLabels,
                monthLabel: customMonthLabels,
                colorTipLabel: customColorTipLabels,
              ),
            ),
          ),
        ),
      );

      // Verify that custom week labels are displayed
      for (String label in customWeekLabels) {
        expect(find.text(label), findsOneWidget);
      }

      // Verify that custom month labels are displayed
      for (String label in customMonthLabels) {
        expect(find.text(label), findsOneWidget);
      }

      // Verify that custom color tip labels are displayed
      for (String label in customColorTipLabels) {
        expect(find.text(label), findsOneWidget);
      }
    });

    testWidgets('calls onClick callback when a cell is tapped',
        (WidgetTester tester) async {
      final startDate = DateTime(2024, 1, 1);
      final endDate = DateTime(2024, 1, 31);
      final colorsets = {1: Colors.red, 2: Colors.green, 3: Colors.blue};
      DateTime? tappedDate;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeatMap(
              startDate: startDate,
              endDate: endDate,
              colorsets: colorsets,
              onClick: (date) {
                tappedDate = date;
              },
            ),
          ),
        ),
      );

      // Tap on the first HeatMapCell
      await tester.tap(find.byType(HeatMapCell).first);
      await tester.pumpAndSettle();

      // Verify that the onClick callback is called with the correct date
      expect(tappedDate, isNotNull);
    });
  });
}
