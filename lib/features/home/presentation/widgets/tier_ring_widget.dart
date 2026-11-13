import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/home/presentation/home_dimens.dart';
import 'package:donuts/features/home/presentation/painters/tier_ring_painter.dart';
import 'package:material_ui/material_ui.dart';

/// Draws the next-tier ring around [child], the avatar, without changing
/// its size.
///
/// When it first shows, the ring waits [AppMotion.slow] for Home to finish
/// coming in, like the Rewards ring, then sweeps from empty to [progress].
/// When [progress] changes, it sweeps from the old value to the new one at
/// once. Under Reduce Motion it shows the value without a sweep.
class TierRingWidget extends StatefulWidget {
  const new({required this.progress, required this.child, super.key});

  /// Share of the way to the next tier, 0 to 1. 1 at the top tier.
  final double progress;
  final Widget child;

  @override
  State<TierRingWidget> createState() => _TierRingWidgetState();
}

class _TierRingWidgetState extends State<TierRingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);
  CurvedAnimation? _curve;
  Animation<double> _sweep = const AlwaysStoppedAnimation(0);
  bool _started = false;

  double get _target => widget.progress.clamp(0.0, 1.0);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    const wait = AppMotion.slow;
    final total = wait + AppMotion.showcase;
    _sweepTo(
      _target,
      duration: total,
      curve: Interval(
        wait.inMicroseconds / total.inMicroseconds,
        1,
        curve: AppMotion.emphasized,
      ),
    );
  }

  @override
  void didUpdateWidget(TierRingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress == widget.progress) return;
    _sweepTo(
      _target,
      duration: AppMotion.showcase,
      curve: AppMotion.emphasized,
    );
  }

  /// Sweeps from what the ring shows now to [to].
  void _sweepTo(double to, {required Duration duration, required Curve curve}) {
    final from = _sweep.value;
    _curve?.dispose();
    final curved = _curve = CurvedAnimation(parent: _controller, curve: curve);
    _sweep = Tween(begin: from, end: to).animate(curved);
    if (context.motion.reduced) {
      _controller.value = 1;
      return;
    }
    _controller
      ..duration = duration
      ..forward(from: 0);
  }

  @override
  void dispose() {
    _curve?.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AnimatedBuilder(
      animation: _sweep,
      child: widget.child,
      builder: (context, child) => CustomPaint(
        foregroundPainter: TierRingPainter(
          progress: _sweep.value,
          start: colors.tierRingStart,
          end: colors.tierRingEnd,
          stroke: HomeDimens.avatarRingStroke,
          gap: HomeDimens.avatarRingGap,
        ),
        child: child,
      ),
    );
  }
}
