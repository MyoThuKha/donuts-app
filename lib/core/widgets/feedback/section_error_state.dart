import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/pill_button.dart';
import 'package:donuts/core/widgets/feedback/section_state_box.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// Shown in place of a section that failed to load, with a compact retry.
class SectionErrorState extends StatelessWidget {
  const new({
    required this.message,
    required this.onRetry,
    this.gutter = true,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  /// False when the parent already pads to the page gutter.
  final bool gutter;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SectionStateBox(
      icon: LucideIcons.cloudAlert,
      iconColor: colors.danger,
      message: message,
      messageStyle: context.text.label,
      gutter: gutter,
      action: AppPillButton(
        label: context.l10n.homeRetry,
        icon: LucideIcons.rotateCw,
        fill: colors.canvas,
        minHeight: AppSizes.compactButton,
        onPressed: onRetry,
      ),
    );
  }
}
