import 'dart:async';

import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/motion/first_frame.dart';
import 'package:material_ui/material_ui.dart';

/// Fades and slides [child] in after `index × delay`, so a column of these
/// enters one after another. Reduce Motion shows [child] at once.
///
/// On a cold start the count starts once [FirstFrame] is on screen, so a
/// slow first frame can't eat into the entrance.
class StaggeredEntrance extends StatefulWidget {
  const new({
    required this.index,
    required this.child,
    this.from = const Offset(0, 0.1),
    this.delay = AppMotion.stagger,
    this.duration = AppMotion.slow,
    this.curve = AppMotion.standard,
    super.key,
  });

  final int index;
  final Widget child;

  /// Start offset as a fraction of the child's size.
  final Offset from;
  final Duration delay;
  final Duration duration;
  final Curve curve;

  @override
  State<StaggeredEntrance> createState() => _StaggeredEntranceState();
}

class _StaggeredEntranceState extends State<StaggeredEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);
  late final CurvedAnimation _progress;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    final wait = widget.delay * widget.index;
    final total = wait + widget.duration;
    _progress = CurvedAnimation(
      parent: _controller,
      curve: Interval(
        wait.inMicroseconds / total.inMicroseconds,
        1,
        curve: widget.curve,
      ),
    );
    if (context.motion.reduced) {
      _controller.value = 1;
    } else {
      _controller.duration = total;
      if (FirstFrame.isShown) {
        _controller.forward();
      } else {
        unawaited(FirstFrame.shown.then((_) => _forward()));
      }
    }
  }

  void _forward() {
    if (mounted) _controller.forward();
  }

  @override
  void dispose() {
    _progress.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _progress,
      child: SlideTransition(
        position: Tween(
          begin: widget.from,
          end: Offset.zero,
        ).animate(_progress),
        child: widget.child,
      ),
    );
  }
}
