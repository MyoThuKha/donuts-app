import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// Shown in place of a section that failed to load, with a retry button.
class SectionErrorState extends StatelessWidget {
  const new({required this.message, required this.onRetry, super.key});

  final String message;
  final VoidCallback onRetry;

  /// Keeps the stadium button compact inside a section.
  static const double _buttonWidth = 160;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.pageGutter,
        vertical: AppSpacing.l,
      ),
      child: Column(
        spacing: AppSpacing.m,
        children: [
          Row(
            spacing: AppSpacing.s,
            children: [
              ExcludeSemantics(
                child: Icon(
                  LucideIcons.circleAlert,
                  size: AppSizes.imageErrorIcon,
                  color: colors.danger,
                ),
              ),
              Expanded(child: Text(message, style: context.text.bodySmall)),
            ],
          ),
          SizedBox(
            width: _buttonWidth,
            child: AppPrimaryButton(
              label: context.l10n.homeRetry,
              onPressed: onRetry,
            ),
          ),
        ],
      ),
    );
  }
}
