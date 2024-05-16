import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeatMapColorTip extends StatelessWidget {
  final Map<int, Color> colorsets;

  /// The size of the heatmap.
  final double? size;

  /// The size of the color tip.
  final double? colorTipSize;

  /// A list of color tip labels.
  final List<String>? colorTipLabel;

  const HeatMapColorTip({
    super.key,
    required this.colorsets,
    this.size,
    this.colorTipSize,
    this.colorTipLabel,
  });

  @override
  Widget build(BuildContext context) {
    if (colorTipSize == null) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (var (idx, data) in colorsets.entries.indexed)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                Container(
                  width: colorTipSize,
                  height: colorTipSize,
                  decoration: BoxDecoration(
                    color: data.value,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                colorTipLabel != null && idx < colorTipLabel!.length
                    ? SizedBox(
                        height: 16,
                        child: Text(
                          colorTipLabel![idx],
                          style: const TextStyle(fontSize: 10),
                        ),
                      )
                    : const SizedBox(height: 16)
              ],
            ),
          ),
        SizedBox(
          width: size != null ? size! : 40,
        )
      ],
    );
  }
}
