import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:material_ui/material_ui.dart';

/// A tappable line of text in the accent colour, such as a shop card's
/// Order online. It dims while pressed.
class AppTextButton extends StatefulWidget {
  const new({required this.label, this.onPressed, super.key});

  final String label;

  /// `null` disables the button.
  final VoidCallback? onPressed;

  @override
  State<AppTextButton> createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton> {
  /// Opacity of the label while a finger is down.
  static const double _pressedOpacity = 0.5;

  bool _pressed = false;

  void _setPressed(bool pressed) {
    if (widget.onPressed != null && pressed != _pressed) {
      setState(() => _pressed = pressed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final onPressed = widget.onPressed;
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: widget.label,
      excludeSemantics: true,
      onTap: onPressed,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        onTap: onPressed,
        child: AnimatedOpacity(
          opacity: _pressed ? _pressedOpacity : 1,
          duration: context.motion.of(AppMotion.fast),
          curve: AppMotion.standard,
          child: Text(
            widget.label,
            style: context.text.label.copyWith(color: context.colors.accent),
          ),
        ),
      ),
    );
  }
}
