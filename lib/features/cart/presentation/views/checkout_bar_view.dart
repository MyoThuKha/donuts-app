import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/widgets/buttons/total_button.dart';
import 'package:donuts/core/widgets/feedback/app_snack_bar.dart';
import 'package:material_ui/material_ui.dart';

/// Checkout with the cart's total, in the bottom bar slot. Checkout isn't
/// built yet, so it says so in a snackbar.
class CheckoutBarView extends StatelessWidget {
  const new({required this.totalMmk, super.key});

  final int totalMmk;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.pageGutter,
          AppSpacing.s,
          AppSpacing.pageGutter,
          AppSpacing.l,
        ),
        child: AppTotalButton(
          label: l10n.cartCheckout,
          totalMmk: totalMmk,
          onPressed: () => context.showMessage(l10n.featureComingSoon),
        ),
      ),
    );
  }
}
