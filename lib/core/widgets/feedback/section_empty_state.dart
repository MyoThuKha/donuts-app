import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// Shown in place of a section that has nothing to show.
class SectionEmptyState extends StatelessWidget {
  const new({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pageGutter,
        vertical: AppSpacing.l,
      ),
      child: Row(
        spacing: AppSpacing.s,
        children: [
          ExcludeSemantics(
            child: Icon(
              LucideIcons.inbox,
              size: AppSizes.imageErrorIcon,
              color: colors.inkSubtle,
            ),
          ),
          Expanded(
            child: Text(
              message,
              style: context.text.bodySmall.copyWith(color: colors.inkSubtle),
            ),
          ),
        ],
      ),
    );
  }
}
