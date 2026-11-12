import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// Looks like the other fields; a tap opens a sheet of the twelve months,
/// named in the current locale.
class MonthFieldWidget extends StatelessWidget {
  const new({
    required this.month,
    required this.hint,
    required this.onChanged,
    super.key,
  });

  static const int monthsInYear = 12;

  final int? month;
  final String hint;
  final ValueChanged<int> onChanged;

  static String nameOf(BuildContext context, int month) =>
      DateFormat.MMMM(Localizations.localeOf(context).toLanguageTag())
          .format(DateTime(2000, month));

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.text;
    final selected = month;
    return Semantics(
      button: true,
      child: Material(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadii.field),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => _pick(context),
          child: Container(
            height: AppSizes.field,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selected == null ? hint : nameOf(context, selected),
                    style: text.body.copyWith(
                      color: selected == null ? colors.inkSubtle : colors.ink,
                    ),
                  ),
                ),
                Icon(LucideIcons.chevronDown, color: colors.inkSubtle),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pick(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final picked = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      backgroundColor: context.colors.surface,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            for (var m = 1; m <= monthsInYear; m++)
              ListTile(
                title: Text(nameOf(context, m), style: context.text.body),
                selected: m == month,
                onTap: () => Navigator.of(context).pop(m),
              ),
          ],
        ),
      ),
    );
    if (picked != null) onChanged(picked);
  }
}
