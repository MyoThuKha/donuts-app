import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:material_ui/material_ui.dart';

/// The white card a section's empty or error state sits in: a tinted icon
/// badge, the message, then an optional [action]. The card reads on the
/// grey canvas beside product tiles and on a coloured backdrop alike.
class SectionStateBox extends StatelessWidget {
  const new({
    required this.icon,
    required this.iconColor,
    required this.message,
    required this.messageStyle,
    required this.gutter,
    this.action,
    super.key,
  });

  final IconData icon;
  final Color iconColor;
  final String message;
  final TextStyle messageStyle;

  /// False when the parent already pads to the page gutter.
  final bool gutter;
  final Widget? action;

  /// How strongly the badge is tinted with [iconColor].
  static const double _badgeTint = 0.12;

  @override
  Widget build(BuildContext context) {
    final action = this.action;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: gutter ? AppSpacing.pageGutter : 0,
        vertical: AppSpacing.s,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: const BorderRadius.all(Radius.circular(AppRadii.card)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.l),
          child: Row(
            spacing: AppSpacing.m,
            children: [
              ExcludeSemantics(
                child: DecoratedBox(
                  decoration: ShapeDecoration(
                    color: iconColor.withValues(alpha: _badgeTint),
                    shape: const CircleBorder(),
                  ),
                  child: SizedBox.square(
                    dimension: AppSizes.stateBadge,
                    child: Icon(
                      icon,
                      size: AppSizes.imageErrorIcon,
                      color: iconColor,
                    ),
                  ),
                ),
              ),
              Expanded(child: Text(message, style: messageStyle)),
              ?action,
            ],
          ),
        ),
      ),
    );
  }
}
