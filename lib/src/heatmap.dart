import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_vertical_heatmap/flutter_vertical_heatmap.dart';
import 'package:flutter_vertical_heatmap/src/heatmap_color_tip.dart';
import 'package:flutter_vertical_heatmap/src/heatmap_week_text.dart';
import 'package:flutter_vertical_heatmap/src/heatmap_row.dart';

/// A HeatMap widget that displays a vertical heatmap.
class HeatMap extends StatelessWidget {
  /// The number of days between the start and end dates.
  final int _dateDifferent;

  /// The start date of the period being displayed.
  final DateTime startDate;

  /// The end date of the period being displayed.
  final DateTime endDate;

  /// The size of the heatmap.
  final double? size;

  /// The font size of the text labels.
  final double? fontSize;

  /// The font size of the color tip.
  final double? colorTipSize;

  /// A map of data points, where each key is a date and each value is the value of the data point.
  final Map<DateTime, int>? datasets;

  /// The margin of the heatmap.
  final EdgeInsets? margin;

  /// The default color of the heatmap cells.
  final Color? defaultColor;

  /// The color of the text labels.
  final Color? textColor;

  /// A map of color sets, where each key is a day of the week and each value is a list of colors.
  final Map<int, Color> colorsets;

  /// The border radius of the heatmap cells.
  final double? borderRadius;

  /// A callback function that is called when a cell in the heatmap is clicked.
  final Function(DateTime)? onClick;

  /// A list of month labels.
  final List<String>? monthLabel;

  /// A list of week labels.
  final List<String>? weekLabel;

  /// A list of color tip labels.
  final List<String>? colorTipLabel;

  HeatMap({
    super.key,
    required this.startDate,
    required this.endDate,
    required this.colorsets,
    this.size,
    this.fontSize,
    this.colorTipSize,
    this.datasets,
    this.defaultColor,
    this.textColor,
    this.borderRadius,
    this.onClick,
    this.margin,
    this.monthLabel,
    this.weekLabel,
    this.colorTipLabel,
  }) : _dateDifferent = endDate.difference(startDate).inDays;

  /// A list of HeatMapRow widgets.
  List<Widget> _heatmapRowList() {
    List<Widget> rows = [];

    for (int datePos = 0 - (startDate.weekday % 7);
        datePos <= _dateDifferent;
        datePos += 7) {
      DateTime firstDay = HeatMapUtils.changeDay(startDate, datePos);
      DateTime lastDayOfWeek = HeatMapUtils.changeDay(firstDay, 6);

      rows.add(HeatMapRow(
        startDate: firstDay,
        numDays: min(endDate.difference(firstDay).inDays + 1, 7),
        size: size,
        defaultColor: defaultColor,
        colorsets: colorsets,
        borderRadius: borderRadius,
        margin: margin,
        onTap: onClick,
        datasets: datasets,
        monthText: lastDayOfWeek.day < 8
            ? monthLabel != null
                ? monthLabel![lastDayOfWeek.month - 1]
                : HeatMapDefault.monthLabel[lastDayOfWeek.month - 1]
            : "",
      ));
    }

    return rows.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                HeatMapColorTip(
                  colorsets: colorsets,
                  size: size,
                  colorTipSize: colorTipSize,
                  colorTipLabel: colorTipLabel,
                ),
                const SizedBox(height: 10),
                HeatMapWeekText(
                  margin: margin,
                  fontSize: fontSize,
                  size: size,
                  fontColor: textColor,
                  weekLabel: weekLabel,
                ),
                const SizedBox(height: 10),
                Column(
                  children: <Widget>[..._heatmapRowList()],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
