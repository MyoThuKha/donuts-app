import 'dart:async';

import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/auth/presentation/widgets/step_progress_painter.dart';
import 'package:material_ui/material_ui.dart';

/// The ring at the top right of each registration step. It sweeps from the
/// previous step's share to this one's; on the last step it then fills and
/// draws a check.
class StepProgressRing extends StatefulWidget {
  const new({required this.step, required this.of, super.key});

  static const double size = 32;

  /// Track opacity against the arc.
  static const double trackAlpha = 0.45;

  final int step;
  final int of;

  @override
  State<StepProgressRing> createState() => _StepProgressRingState();
}

class _StepProgressRingState extends State<StepProgressRing>
    with TickerProviderStateMixin {
  late final AnimationController _sweep = AnimationController(vsync: this);
  late final AnimationController _check = AnimationController(vsync: this);
  bool _started = false;

  bool get _isLast => widget.step >= widget.of;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    unawaited(_play(context.motion));
  }

  Future<void> _play(MotionScale motion) async {
    _sweep.duration = motion.of(AppMotion.slow);
    _check.duration = motion.of(AppMotion.medium);
    try {
      await _sweep.animateTo(1, curve: AppMotion.standard).orCancel;
      if (_isLast && mounted) await _check.forward().orCancel;
    } on TickerCanceled {
      // The step was left before the ring finished; nothing to clean up.
    }
  }

  @override
  void dispose() {
    _sweep.dispose();
    _check.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      label: context.l10n.stepOf(widget.step, widget.of),
      child: SizedBox.square(
        dimension: StepProgressRing.size,
        child: CustomPaint(
          painter: StepProgressPainter(
            sweep: _sweep,
            check: _check,
            from: (widget.step - 1) / widget.of,
            to: widget.step / widget.of,
            track: colors.primary.withValues(
              alpha: StepProgressRing.trackAlpha,
            ),
            arc: colors.accent,
            mark: colors.onPrimary,
          ),
        ),
      ),
    );
  }
}
