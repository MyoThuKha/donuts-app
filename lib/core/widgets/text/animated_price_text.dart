import 'package:donuts/core/format/number_format.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:material_ui/material_ui.dart';

/// A price in MMK, such as `3,200 MMK`, that counts from its previous value
/// to the new one.
class AnimatedPriceText extends StatelessWidget {
  const new({required this.priceMmk, required this.style, super.key});

  final int priceMmk;
  final TextStyle style;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(end: priceMmk.toDouble()),
    duration: context.motion.of(AppMotion.medium),
    curve: AppMotion.standard,
    builder: (context, value, _) => Text(
      context.l10n.productPrice(formatGrouped(value.round())),
      style: style,
    ),
  );
}
