import 'package:donuts/core/format/number_format.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/core/widgets/text/animated_price_text.dart';
import 'package:material_ui/material_ui.dart';

/// The filled button with an action and a live total, such as
/// "ADD TO CART | 3,200 MMK". The total counts to each new value. While
/// [loading] it morphs into a circle with a spinner and ignores taps.
class AppTotalButton extends StatelessWidget {
  const new({
    required this.label,
    required this.totalMmk,
    required this.onPressed,
    this.loading = false,
    super.key,
  });

  final String label;
  final int totalMmk;
  final VoidCallback onPressed;
  final bool loading;

  static const double _dividerWidth = 1;
  static const double _dividerHeight = 16;

  @override
  Widget build(BuildContext context) {
    final style = context.text.button;
    return AppPrimaryButton(
      label: '$label, ${context.l10n.productPrice(formatGrouped(totalMmk))}',
      loading: loading,
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.m,
        children: [
          Text(label.toUpperCase(), style: style),
          ColoredBox(
            color: context.colors.onPrimary,
            child: const SizedBox(width: _dividerWidth, height: _dividerHeight),
          ),
          AnimatedPriceText(priceMmk: totalMmk, style: style),
        ],
      ),
    );
  }
}
