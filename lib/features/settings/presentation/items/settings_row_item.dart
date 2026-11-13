import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// One Settings row: an icon, a bold label, and on the right a value, a
/// chevron when the row opens something, or both. While [busy] a small
/// spinner takes the chevron's place and taps are ignored.
class SettingsRowItem extends StatelessWidget {
  const new({
    required this.icon,
    required this.label,
    this.value,
    this.onTap,
    this.filledIcon = false,
    this.busy = false,
    super.key,
  });

  final IconData icon;
  final String label;

  /// Grey text on the right, such as a date.
  final String? value;

  /// Null makes the row read-only, without a chevron.
  final VoidCallback? onTap;

  /// Puts the icon in a blue circle, as the design draws Logout.
  final bool filledIcon;

  /// Whatever the row started is still running.
  final bool busy;

  static const double iconSize = 24;
  static const double _spinnerSize = 20;
  static const double _spinnerStroke = 2.5;
  static const double filledIconCircle = 40;
  static const double minHeight = 60;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final value = this.value;
    return MergeSemantics(
      child: InkWell(
        onTap: busy ? null : onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: minHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.authGutter - AppSpacing.s,
              vertical: AppSpacing.s,
            ),
            child: Row(
              spacing: AppSpacing.l,
              children: [
                _icon(context),
                Expanded(child: Text(label, style: context.text.sectionTitle)),
                // Shares the row with the label, so a long value such as
                // "Device language" wraps on small phones at large text
                // instead of overflowing, and stays flush right.
                if (value != null)
                  Expanded(
                    child: Text(
                      value,
                      textAlign: TextAlign.end,
                      style: context.text.body,
                    ),
                  ),
                if (busy)
                  const SizedBox.square(
                    dimension: _spinnerSize,
                    child: CircularProgressIndicator(
                      strokeWidth: _spinnerStroke,
                    ),
                  )
                else if (onTap != null)
                  Icon(
                    LucideIcons.chevronRight,
                    size: iconSize,
                    color: colors.ink,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Plain icons sit in a circle-sized slot, so every label lines up with
  /// the filled one.
  Widget _icon(BuildContext context) {
    final colors = context.colors;
    return SizedBox.square(
      dimension: filledIconCircle,
      child: filledIcon
          ? DecoratedBox(
              decoration: ShapeDecoration(
                color: colors.primary,
                shape: const CircleBorder(),
              ),
              child: Icon(icon, size: iconSize, color: colors.onPrimary),
            )
          : Icon(icon, size: iconSize, color: colors.inkMuted),
    );
  }
}
