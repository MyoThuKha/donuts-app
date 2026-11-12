import 'package:donuts/core/format/number_format.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/product/presentation/product_dimens.dart';
import 'package:material_ui/material_ui.dart';

/// The Add to cart stadium with the live total. It follows
/// `AppPrimaryButton`: it shrinks on press, and while [adding] it morphs
/// into a circle with a spinner and ignores taps.
class AddToCartBarView extends StatefulWidget {
  const new({
    required this.total,
    required this.adding,
    required this.onPressed,
    super.key,
  });

  final int total;
  final bool adding;
  final VoidCallback onPressed;

  @override
  State<AddToCartBarView> createState() => _AddToCartBarViewState();
}

class _AddToCartBarViewState extends State<AddToCartBarView> {
  static const double _spinnerSize = 22;
  static const double _spinnerStroke = 2.5;

  bool _pressed = false;

  void _setPressed(bool pressed) {
    if (!widget.adding && pressed != _pressed) {
      setState(() => _pressed = pressed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final onTap = widget.adding ? null : widget.onPressed;
    return Semantics(
      button: true,
      enabled: onTap != null,
      label:
          '${l10n.productAddToCart}, '
          '${l10n.productPrice(formatGrouped(widget.total))}',
      excludeSemantics: true,
      onTap: onTap,
      child: GestureDetector(
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        onTap: onTap,
        child: AnimatedScale(
          scale: _pressed ? AppMotion.pressScale : 1,
          duration: context.motion.of(AppMotion.fast),
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
    final motion = context.motion;
    // heightFactor 1: in the Scaffold's bottom slot, a plain Center would
    // take the whole screen height.
    return Center(
      heightFactor: 1,
      child: AnimatedContainer(
        duration: motion.of(AppMotion.medium),
        curve: AppMotion.emphasized,
        width: widget.adding ? AppSizes.button : fullWidth,
        height: AppSizes.button,
        decoration: ShapeDecoration(
          color: context.colors.primary,
          shape: const StadiumBorder(),
        ),
        alignment: Alignment.center,
        child: AnimatedSwitcher(
          duration: motion.of(AppMotion.fast),
          child: widget.adding ? _spinner(context) : _label(context),
        ),
      ),
    );
  }

  Widget _spinner(BuildContext context) => SizedBox.square(
    dimension: _spinnerSize,
    child: CircularProgressIndicator(
      strokeWidth: _spinnerStroke,
      color: context.colors.onPrimary,
    ),
  );

  Widget _label(BuildContext context) {
    final style = context.text.button;
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.m,
        children: [
          Text(context.l10n.productAddToCart.toUpperCase(), style: style),
          ColoredBox(
            color: context.colors.onPrimary,
            child: const SizedBox(
              width: ProductDimens.dividerThickness,
              height: ProductDimens.totalDividerHeight,
            ),
          ),
          _AnimatedTotal(total: widget.total, style: style),
        ],
      ),
    );
  }
}

/// Counts from the previous total to the new one.
class _AnimatedTotal extends StatelessWidget {
  const new({required this.total, required this.style});

  final int total;
  final TextStyle style;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(end: total.toDouble()),
    duration: context.motion.of(AppMotion.medium),
    curve: AppMotion.standard,
    builder: (context, value, _) => Text(
      context.l10n.productPrice(formatGrouped(value.round())),
      style: style,
    ),
  );
}
