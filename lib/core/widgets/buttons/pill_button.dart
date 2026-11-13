import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/press_grow.dart';
import 'package:material_ui/material_ui.dart';

/// A compact stadium with the label in capitals, such as Home's Explore
/// now. It sizes to its label and grows while held.
class AppPillButton extends StatelessWidget {
  const new({
    required this.label,
    this.onPressed,
    this.icon,
    this.fill,
    this.minHeight = 0,
    super.key,
  });

  final String label;

  /// `null` disables the button.
  final VoidCallback? onPressed;

  /// Shown before the label, in the label's colour.
  final IconData? icon;

  /// The stadium's colour. White when null; a white card needs another.
  final Color? fill;

  /// Grows the stadium to at least this height, such as a tap target.
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final style = context.text.button.copyWith(color: colors.primary);
    final icon = this.icon;
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: label,
      excludeSemantics: true,
      onTap: onPressed,
      child: AppPressGrow(
        onTap: onPressed,
        child: DecoratedBox(
          decoration: ShapeDecoration(
            color: fill ?? colors.surface,
            shape: const StadiumBorder(),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.l,
              vertical: AppSpacing.s,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: minHeight > 0 ? minHeight - AppSpacing.s * 2 : 0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: AppSpacing.xs,
                children: [
                  if (icon != null)
                    Icon(
                      icon,
                      size: AppSizes.circleButtonIcon,
                      color: colors.primary,
                    ),
                  Text(label.toUpperCase(), style: style),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
