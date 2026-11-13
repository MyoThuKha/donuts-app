import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/settings/presentation/items/settings_row_item.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// One choice in the language sheet: its name, and a check when selected.
class LanguageOptionItem extends StatelessWidget {
  const new({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;

  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      selected: selected,
      inMutuallyExclusiveGroup: true,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: SettingsRowItem.minHeight,
          ),
          child: Row(
            spacing: AppSpacing.l,
            children: [
              Expanded(child: Text(label, style: context.text.sectionTitle)),
              if (selected)
                Icon(
                  LucideIcons.check,
                  size: SettingsRowItem.iconSize,
                  color: context.colors.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
