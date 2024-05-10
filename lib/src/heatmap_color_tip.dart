import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HeatMapColorTip extends StatelessWidget {
  final Map<int, Color> colorsets;

  /// The size of the heatmap.
  final double? size;

  /// The size of the color tip.
  final double? colorTipSize;

  const HeatMapColorTip({
    super.key,
    required this.colorsets,
    this.size,
    this.colorTipSize,
  });

  @override
  Widget build(BuildContext context) {
    var keys = colorsets.keys.toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (var (idx, data) in colorsets.entries.indexed)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                Container(
                  width: colorTipSize ?? 20,
                  height: colorTipSize ?? 20,
                  decoration: BoxDecoration(
                    color: data.value,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Text(
                  '${0 < idx ? keys[idx - 1] : 0}~${data.key}',
                  style: const TextStyle(fontSize: 10),
                )
              ],
            ),
          ),
        SizedBox(
          width: size != null ? size! : 40 - 4,
        )
      ],
    );
  }
}
