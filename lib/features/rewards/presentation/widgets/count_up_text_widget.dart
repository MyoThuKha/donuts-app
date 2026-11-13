import 'package:donuts/core/format/number_format.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:material_ui/material_ui.dart';

/// Counts from 0 up to [value] as [progress] runs from 0 to 1. When
/// [value] changes later, it counts on from the old value. Screen readers
/// hear only the final value.
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
      child: TweenAnimationBuilder<double>(
        tween: Tween(end: value.toDouble()),
        duration: context.motion.of(AppMotion.slow),
        curve: AppMotion.standard,
        builder: (context, current, _) => AnimatedBuilder(
          animation: progress,
          builder: (context, _) {
            final shown = (current * progress.value.clamp(0.0, 1.0)).round();
            return Text(formatGrouped(shown), maxLines: 1, style: style);
          },
        ),
      ),
    );
  }
}
