import 'package:flutter/material.dart';

class HeatMapUtils {
  /// Get exactly one year before of [referenceDate].
  static DateTime oneYearBefore(final DateTime referenceDate) =>
      DateTime(referenceDate.year - 1, referenceDate.month, referenceDate.day);

  /// Change day of [referenceDate].
  static DateTime changeDay(final DateTime referenceDate, final int dayCount) =>
      DateTime(referenceDate.year, referenceDate.month,
          referenceDate.day + dayCount);

  /// Get color from [colorsets] using [dataValue].
  static Color? getColor(Map<int, Color>? colorsets, int? dataValue) {
    int result = 0;

    colorsets?.forEach((key, value) {
      if (key <= (dataValue ?? 0)) result = key;
    });

    return colorsets?[result];
  }
}
