import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/press_grow.dart';
import 'package:material_ui/material_ui.dart';

/// The filled stadium call-to-action, shared by every screen. It grows a
/// little while held, and while [loading] it morphs into a circle holding a
/// spinner and ignores taps.
class AppPrimaryButton extends StatefulWidget {
  const new({
    required this.label,
    this.child,
    this.onPressed,
    this.loading = false,
    super.key,
  });

  /// Read by screen readers, and shown in capitals when there's no [child].
  final String label;

  /// Content in place of the capitalised [label], such as Add to cart's
  /// running total. Style it with `context.text.button`.
  final Widget? child;

  /// `null` disables the button.
  final VoidCallback? onPressed;
  final bool loading;

  @override
  State<AppPrimaryButton> createState() => _AppPrimaryButtonState();
}

class _AppPrimaryButtonState extends State<AppPrimaryButton> {
  static const double _spinnerSize = 22;
  static const double _spinnerStroke = 2.5;

  bool get _enabled => widget.onPressed != null && !widget.loading;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: _enabled,
      label: widget.label,
      excludeSemantics: true,
      onTap: _enabled ? widget.onPressed : null,
      child: AppPressGrow(
        onTap: _enabled ? widget.onPressed : null,
        pressedScale: AppMotion.pressGrowWide,
        child: LayoutBuilder(
          builder: (context, constraints) =>
              _body(context, constraints.maxWidth),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, double fullWidth) {
    final colors = context.colors;
    // heightFactor 1: in a Scaffold's bottom slot, a plain Center would take
    // the whole screen height.
    return Center(
      heightFactor: 1,
      child: AnimatedContainer(
        duration: context.motion.of(AppMotion.medium),
        curve: AppMotion.emphasized,
        width: widget.loading ? AppSizes.filledButton : fullWidth,
        height: AppSizes.filledButton,
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

  Widget _label(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
    child: FittedBox(
      fit: BoxFit.scaleDown,
      child:
          widget.child ??
          Text(
            widget.label.toUpperCase(),
            maxLines: 1,
            style: context.text.button,
          ),
    ),
  );
}
