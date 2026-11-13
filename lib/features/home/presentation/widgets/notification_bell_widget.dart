import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/badges/app_tag.dart';
import 'package:donuts/core/widgets/badges/edge_tag.dart';
import 'package:donuts/features/home/presentation/widgets/press_scale_widget.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// The highlight bell tag, flush with the right edge, with the unread
/// count. Press feedback only.
class NotificationBellWidget extends StatelessWidget {
  const new({required this.count, super.key});

  /// Null while the member summary loads: the bell shows no count.
  final int? count;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final count = this.count;
    return Semantics(
      button: true,
      label: context.l10n.homeNotifications(count ?? 0),
      excludeSemantics: true,
      child: PressScaleWidget(
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
                LucideIcons.bell,
                size: AppSizes.edgeTagIcon,
                color: colors.onPrimary,
              ),
              if (count != null && count > 0)
                AppTag.count(count: count, diameter: AppSizes.edgeTagBadge),
            ],
          ),
        ),
      ),
    );
  }
}
