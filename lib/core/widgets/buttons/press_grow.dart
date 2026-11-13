import 'package:donuts/core/motion/app_motion.dart';
import 'package:flutter/physics.dart';
import 'package:material_ui/material_ui.dart';

/// Grows [child] the moment a finger lands, holds it there while the finger
/// stays down, and springs it back on release or cancel. [onTap] runs on
/// release only. The button components use it for their press feedback.
///
/// The spring carries its speed, so a quick tap turns straight back instead
/// of restarting. Reduce Motion keeps the child at its own size. The layout
/// size never changes: only the painting grows.
class AppPressGrow extends StatefulWidget {
  const new({
    required this.onTap,
    required this.child,
    this.pressedScale = AppMotion.pressGrow,
    super.key,
  });

  /// `null` disables the press.
  final VoidCallback? onTap;
  final Widget child;

  /// The scale the child grows to while held.
  final double pressedScale;

  @override
  State<AppPressGrow> createState() => _AppPressGrowState();
}

class _AppPressGrowState extends State<AppPressGrow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scale = AnimationController.unbounded(
    vsync: this,
    value: 1,
  );

  bool _pressed = false;

  void _press(bool pressed) {
    if (pressed == _pressed) return;
    _pressed = pressed;
    final target = pressed && !context.motion.reduced
        ? widget.pressedScale
        : 1.0;
    _scale.animateWith(
      SpringSimulation(
        AppMotion.pressSpring,
        _scale.value,
        target,
        _scale.velocity,
        snapToEnd: true,
      ),
    );
  }

  @override
  void didUpdateWidget(AppPressGrow oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Disabled mid-press: let go, so it doesn't stay grown.
    if (widget.onTap == null) _press(false);
  }

  @override
  void dispose() {
    _scale.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onTap != null;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: enabled ? (_) => _press(true) : null,
      onTapUp: enabled ? (_) => _press(false) : null,
      onTapCancel: enabled ? () => _press(false) : null,
      onTap: widget.onTap,
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}
