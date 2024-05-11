import 'package:flutter/material.dart';
import 'package:flutter_vertical_heatmap/src/heatmap_constants.dart';

/// A HeatMapWeekText widget that displays a row of text labels.
class HeatMapWeekText extends StatelessWidget {
  /// The margin of the text labels.
  final EdgeInsets? margin;

  /// The font size of the text labels.
  final double? fontSize;

  /// The size of the heatmap.
  final double? size;

  /// The color of the text labels.
  final Color? fontColor;

  /// A list of week labels.
  final List<String>? weekLabel;

  const HeatMapWeekText({
    super.key,
    this.margin,
    this.fontSize,
    this.size,
    this.fontColor,
    this.weekLabel = HeatMapDefault.weekLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: size ?? 40),
        for (String label in weekLabel ?? HeatMapDefault.weekLabel)
          Container(
            margin: margin ?? const EdgeInsets.all(2),
            width: size ?? 40,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize ?? 12,
                color: label ==
                        (weekLabel != null
                            ? weekLabel![0]
                            : HeatMapDefault.weekLabel[0])
                    ? Colors.red
                    : label ==
                            (weekLabel != null
                                ? weekLabel![6]
                                : HeatMapDefault.weekLabel[6])
                        ? Colors.blue
                        : fontColor,
              ),
            ),
          ),
        SizedBox(width: size ?? 40),
      ],
    );
  }
}
