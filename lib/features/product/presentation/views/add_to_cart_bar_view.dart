import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/widgets/buttons/total_button.dart';
import 'package:material_ui/material_ui.dart';

/// Add to cart with the live total. While [adding] it shows a spinner and
/// ignores taps.
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
  Widget build(BuildContext context) => AppTotalButton(
    label: context.l10n.productAddToCart,
    totalMmk: total,
    loading: adding,
    onPressed: onPressed,
  );
}
