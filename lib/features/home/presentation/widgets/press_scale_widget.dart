import 'package:donuts/core/motion/app_motion.dart';
import 'package:material_ui/material_ui.dart';

/// Shrinks [child] while pressed and springs it back, for controls whose
/// tap has no action yet beyond feedback. Callers add the semantics.
class PressScaleWidget extends StatefulWidget {
  const new({required this.child, this.onTap, super.key});

  final Widget child;
  final VoidCallback? onTap;

  @override
  State<PressScaleWidget> createState() => _PressScaleWidgetState();
}

class _PressScaleWidgetState extends State<PressScaleWidget> {
  bool _pressed = false;

  void _setPressed(bool pressed) {
    if (pressed != _pressed) setState(() => _pressed = pressed);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap ?? () {},
      child: AnimatedScale(
        scale: _pressed ? AppMotion.pressScale : 1,
        duration: context.motion.of(AppMotion.fast),
        curve: AppMotion.standard,
        child: widget.child,
      ),
    );
  }
}
