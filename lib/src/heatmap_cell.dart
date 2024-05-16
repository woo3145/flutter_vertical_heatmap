import 'package:flutter/material.dart';
import 'package:flutter_vertical_heatmap/src/heatmap_constants.dart';

/// A HeatMapCell widget that represents a cell in a heatmap.
class HeatMapCell extends StatelessWidget {
  /// The date of the cell.
  final DateTime date;

  /// The size of the cell.
  final double? size;

  /// The border radius of the cell.
  final double? borderRadius;

  /// The background color of the cell.
  final Color? backgroundColor;

  /// The selected color of the cell.
  final Color? selectedColor;

  /// The margin of the cell.
  final EdgeInsets? margin;

  /// A callback function that is called when the cell is tapped.
  final void Function(DateTime)? onTap;

  const HeatMapCell({
    super.key,
    required this.date,
    this.margin,
    this.size,
    this.borderRadius,
    this.backgroundColor,
    this.selectedColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(2),
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap!(date);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? HeatMapDefault.surfaceColor,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
          ),
          width: size,
          height: size,
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              color: selectedColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 5)),
            ),
          ),
        ),
      ),
    );
  }
}
