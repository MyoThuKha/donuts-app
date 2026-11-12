import 'package:donuts/core/format/number_format.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/home/presentation/home_dimens.dart';
import 'package:donuts/features/home/presentation/widgets/press_scale_widget.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// The highlight bell pill with the unread count. Press feedback only.
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
        child: DecoratedBox(
          decoration: ShapeDecoration(
            color: colors.highlight,
            shape: const StadiumBorder(),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpacing.xs,
              children: [
                Icon(
                  LucideIcons.bell,
                  size: HomeDimens.bellIcon,
                  color: colors.onPrimary,
                ),
                if (count != null && count > 0) _Badge(count: count),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const new({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: colors.surface,
        shape: const StadiumBorder(),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: HomeDimens.bellBadge,
          minHeight: HomeDimens.bellBadge,
        ),
        child: Center(
          widthFactor: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            child: Text(
              formatGrouped(count),
              style: context.text.caption.copyWith(
                color: colors.highlight,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
