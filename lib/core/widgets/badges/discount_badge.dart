import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/widgets/badges/app_tag.dart';
import 'package:material_ui/material_ui.dart';

/// "50% off" on product tiles and Product detail.
class DiscountBadge extends StatelessWidget {
  const new({required this.percent, super.key});

  final int percent;

  @override
  Widget build(BuildContext context) =>
      AppTag(label: context.l10n.discountOff(percent));
}
