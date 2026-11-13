import 'package:donuts/core/format/number_format.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/features/product/presentation/product_dimens.dart';
import 'package:material_ui/material_ui.dart';

/// Add to cart with the live total, on the shared filled button. While
/// [adding] it morphs into a circle with a spinner and ignores taps.
class AddToCartBarView extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final style = context.text.button;
    return AppPrimaryButton(
      label:
          '${l10n.productAddToCart}, '
          '${l10n.productPrice(formatGrouped(total))}',
      loading: adding,
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.m,
        children: [
          Text(l10n.productAddToCart.toUpperCase(), style: style),
          ColoredBox(
            color: context.colors.onPrimary,
            child: const SizedBox(
              width: ProductDimens.dividerThickness,
              height: ProductDimens.totalDividerHeight,
            ),
          ),
          _AnimatedTotal(total: total, style: style),
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
