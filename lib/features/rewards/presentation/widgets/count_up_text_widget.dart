import 'package:donuts/core/format/number_format.dart';
import 'package:material_ui/material_ui.dart';

/// Counts from 0 up to [value] as [progress] runs from 0 to 1. Screen
/// readers hear only the final value.
class CountUpText extends StatelessWidget {
  const new({
    required this.progress,
    required this.value,
    required this.style,
    super.key,
  });

  final Animation<double> progress;
  final int value;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: formatGrouped(value),
      excludeSemantics: true,
      child: AnimatedBuilder(
        animation: progress,
        builder: (context, _) {
          final shown = (value * progress.value.clamp(0.0, 1.0)).round();
          return Text(formatGrouped(shown), maxLines: 1, style: style);
        },
      ),
    );
  }
}
