import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/text/animated_price_text.dart';
import 'package:material_ui/material_ui.dart';

/// The cart's total, read from the database, in the bottom bar slot. It
/// counts to each new value.
class CartTotalView extends StatelessWidget {
  const new({required this.totalMmk, super.key});

  final int totalMmk;

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    return ColoredBox(
      color: context.colors.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.pageGutter,
            AppSpacing.l,
            AppSpacing.pageGutter,
            AppSpacing.l,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(context.l10n.cartTotal, style: text.sectionTitle),
              ),
              AnimatedPriceText(priceMmk: totalMmk, style: text.sectionTitle),
            ],
          ),
        ),
      ),
    );
  }
}
