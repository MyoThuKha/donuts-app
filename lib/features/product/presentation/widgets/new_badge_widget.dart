import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/widgets/badges/app_tag.dart';
import 'package:material_ui/material_ui.dart';

/// "New" on Product detail.
class NewBadgeWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) => AppTag(
    label: context.l10n.productNew,
    cornerRadius: AppRadii.badge,
    rim: false,
  );
}
