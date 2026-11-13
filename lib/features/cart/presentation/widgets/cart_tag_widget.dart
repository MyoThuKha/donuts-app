import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/badges/app_tag.dart';
import 'package:donuts/core/widgets/badges/edge_tag.dart';
import 'package:donuts/core/widgets/buttons/press_grow.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// The cart tag flush with the right edge, shaped like the Home bell, with
/// the number of items. The count hides when the cart is empty.
class CartTagWidget extends StatelessWidget {
  const new({required this.count, required this.onTap, super.key});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // A node of its own: the header band around it reads as one.
    return Semantics(
      container: true,
      button: true,
      label: context.l10n.cartOpen(count),
      excludeSemantics: true,
      onTap: onTap,
      child: AppPressGrow(
        onTap: onTap,
        child: EdgeTag(
          color: colors.highlight,
          height: AppSizes.edgeTagHeight,
          rim: colors.surface,
          padding: EdgeTag.iconPadding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.s,
            children: [
              Icon(
                LucideIcons.shoppingCart,
                size: AppSizes.edgeTagIcon,
                color: colors.onPrimary,
              ),
              if (count > 0)
                AppTag.count(count: count, diameter: AppSizes.edgeTagBadge),
            ],
          ),
        ),
      ),
    );
  }
}
