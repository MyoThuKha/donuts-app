import 'dart:math' as math;

import 'package:donuts/core/motion/app_motion.dart';
import 'package:material_ui/material_ui.dart';

/// Shakes [child] sideways each time [trigger] increases.
class ShakeWidget extends StatefulWidget {
  const new({required this.trigger, required this.child, super.key});

  static const double distance = 8;
  static const int cycles = 3;

  final int trigger;
  final Widget child;

  @override
  State<ShakeWidget> createState() => _ShakeWidgetState();
}

class _ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);

  @override
  void didUpdateWidget(ShakeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.trigger > oldWidget.trigger) {
      _controller
        ..duration = context.motion.cue(AppMotion.slow)
        ..forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value;
        final dx =
            math.sin(t * ShakeWidget.cycles * 2 * math.pi) *
            ShakeWidget.distance *
            (1 - t);
        return Transform.translate(offset: Offset(dx, 0), child: child);
      },
      child: widget.child,
    );
  }
}
