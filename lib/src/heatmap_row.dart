import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vertical_heatmap/flutter_vertical_heatmap.dart';
import 'package:flutter_vertical_heatmap/src/heatmap_cell.dart';

/// A HeatMapRow widget that represents a row in a heatmap.
class HeatMapRow extends StatelessWidget {
  /// The start date of the period being displayed.
  final DateTime startDate;

  /// The number of days in the row.
  final int numDays;

  /// The size of the heatmap cells.
  final double? size;

  /// The default color of the heatmap cells.
  final Color? defaultColor;

  /// A map of data points, where each key is a date and each value is the value of the data point.
  final Map<DateTime, int>? datasets;

  /// The color of the text labels.
  final Color? textColor;

  /// A map of color sets, where each key is a day of the week and each value is a list of colors.
  final Map<int, Color>? colorsets;

  /// The border radius of the heatmap cells.
  final double? borderRadius;

  /// The margin of the heatmap cells.
  final EdgeInsets? margin;

  /// The month text to display.
  final String? monthText;

  /// A callback function that is called when a cell in the heatmap is clicked.
  final void Function(DateTime)? onTap;

  const HeatMapRow({
    super.key,
    required this.startDate,
    required this.numDays,
    this.size,
    this.defaultColor,
    this.datasets,
    this.textColor,
    this.colorsets,
    this.borderRadius,
    this.margin,
    this.monthText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    /// A list of HeatMapCell widgets.
    List<Widget> dayCells = List.generate(
      numDays,
      (i) => HeatMapCell(
        date: HeatMapUtils.changeDay(startDate, i),
        backgroundColor: defaultColor,
        size: size,
        borderRadius: borderRadius,
        margin: margin,
        onTap: onTap,
        selectedColor: HeatMapUtils.getColor(
          colorsets,
          datasets?[DateTime(
            startDate.year,
            startDate.month,
            startDate.day + i - (startDate.weekday % 7),
          )],
        ),
      ),
    );

    /// A list of empty space widgets.
    List<Widget> emptySpaces = numDays != 7
        ? List.generate(
            7 - numDays,
            (i) => Container(
              margin: margin ?? const EdgeInsets.all(2),
              width: size ?? 40,
              height: size ?? 40,
            ),
          )
        : [];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: size ?? 40,
          child: Text(monthText ?? ""),
        ),
        ...dayCells,
        ...emptySpaces,
        SizedBox(width: size ?? 40),
      ],
    );
  }
}
