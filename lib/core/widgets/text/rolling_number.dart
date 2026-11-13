import 'package:donuts/core/format/number_format.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:material_ui/material_ui.dart';

/// A number that rolls to its new value: the old one slides out and the new
/// one slides in, upwards when the value grows and downwards when it
/// shrinks. Under Reduce Motion it swaps instantly.
class RollingNumber extends StatefulWidget {
  const new({required this.value, required this.style, super.key});

  final int value;
  final TextStyle style;

  @override
  State<RollingNumber> createState() => _RollingNumberState();
}

class _RollingNumberState extends State<RollingNumber> {
  /// 1 when the value last grew, -1 when it shrank.
  double _direction = 1;

  @override
  void didUpdateWidget(RollingNumber oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _direction = widget.value > oldWidget.value ? 1 : -1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final number = Text(
      formatGrouped(widget.value),
      key: ValueKey(widget.value),
      style: widget.style,
    );
    if (context.motion.reduced) return number;
    return ClipRect(
      child: AnimatedSwitcher(
        duration: AppMotion.fast,
        switchInCurve: AppMotion.standard,
        switchOutCurve: AppMotion.standard,
        // A new closure each build: AnimatedSwitcher only re-applies the
        // builder to the outgoing number when the builder changes, and the
        // outgoing number must leave in the current direction.
        transitionBuilder: (child, animation) =>
            _slide(child, animation, direction: _direction),
        child: number,
      ),
    );
  }

  /// The incoming number starts one line below (or above) and the outgoing
  /// one, whose animation runs in reverse, leaves the other way.
  Widget _slide(
    Widget child,
    Animation<double> animation, {
    required double direction,
  }) {
    final incoming = child.key == ValueKey(widget.value);
    final from = Offset(0, incoming ? direction : -direction);
    return SlideTransition(
      position: Tween(begin: from, end: Offset.zero).animate(animation),
      child: child,
    );
  }
}
