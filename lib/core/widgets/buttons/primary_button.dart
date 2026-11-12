import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:material_ui/material_ui.dart';

/// The stadium call-to-action. It shrinks on press, and while [loading] it
/// morphs into a circle holding a spinner and ignores taps.
class AppPrimaryButton extends StatefulWidget {
  const new({
    required this.label,
    this.onPressed,
    this.loading = false,
    super.key,
  });

  final String label;

  /// `null` disables the button.
  final VoidCallback? onPressed;
  final bool loading;

  @override
  State<AppPrimaryButton> createState() => _AppPrimaryButtonState();
}

class _AppPrimaryButtonState extends State<AppPrimaryButton> {
  static const double _spinnerSize = 22;
  static const double _spinnerStroke = 2.5;

  bool _pressed = false;

  bool get _enabled => widget.onPressed != null && !widget.loading;

  void _setPressed(bool pressed) {
    if (_enabled && pressed != _pressed) setState(() => _pressed = pressed);
  }

  @override
  Widget build(BuildContext context) {
    final motion = context.motion;
    return Semantics(
      button: true,
      enabled: _enabled,
      label: widget.label,
      excludeSemantics: true,
      onTap: _enabled ? widget.onPressed : null,
      child: GestureDetector(
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        onTap: _enabled ? widget.onPressed : null,
        child: AnimatedScale(
          scale: _pressed ? AppMotion.pressScale : 1,
          duration: motion.of(AppMotion.fast),
          curve: AppMotion.standard,
          child: LayoutBuilder(
            builder: (context, constraints) =>
                _body(context, constraints.maxWidth),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, double fullWidth) {
    final colors = context.colors;
    return Center(
      child: AnimatedContainer(
        duration: context.motion.of(AppMotion.medium),
        curve: AppMotion.emphasized,
        width: widget.loading ? AppSizes.button : fullWidth,
        height: AppSizes.button,
        decoration: ShapeDecoration(
          color: widget.onPressed == null ? colors.disabled : colors.primary,
          shape: const StadiumBorder(),
        ),
        alignment: Alignment.center,
        child: AnimatedSwitcher(
          duration: context.motion.of(AppMotion.fast),
          child: widget.loading ? _spinner(colors.onPrimary) : _label(context),
        ),
      ),
    );
  }

  Widget _spinner(Color color) => SizedBox.square(
    dimension: _spinnerSize,
    child: CircularProgressIndicator(strokeWidth: _spinnerStroke, color: color),
  );

  Widget _label(BuildContext context) => FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      widget.label.toUpperCase(),
      maxLines: 1,
      style: context.text.button,
    ),
  );
}
