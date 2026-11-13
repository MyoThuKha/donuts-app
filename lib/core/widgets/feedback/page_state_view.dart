import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:material_ui/material_ui.dart';

/// A whole page's empty or error state, centred: a large tinted icon
/// badge, a bold [title], a softer [message], then an optional [action].
/// Sections use `SectionErrorState` instead.
class PageStateView extends StatelessWidget {
  const new({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    this.action,
    super.key,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final Widget? action;

  /// How strongly the badge is tinted with [iconColor].
  static const double _badgeTint = 0.12;

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final action = this.action;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.authGutter),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ExcludeSemantics(
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  color: iconColor.withValues(alpha: _badgeTint),
                  shape: const CircleBorder(),
                ),
                child: SizedBox.square(
                  dimension: AppSizes.pageStateBadge,
                  child: Icon(
                    icon,
                    size: AppSizes.pageStateIcon,
                    color: iconColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xl),
              child: Text(
                title,
                style: text.sectionTitle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.s),
              child: Text(
                message,
                style: text.body,
                textAlign: TextAlign.center,
              ),
            ),
            if (action != null)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xxl),
                child: SizedBox(width: AppSizes.pageStateButton, child: action),
              ),
          ],
        ),
      ),
    );
  }
}
