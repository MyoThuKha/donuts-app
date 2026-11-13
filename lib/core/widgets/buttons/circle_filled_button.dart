import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/press_grow.dart';
import 'package:material_ui/material_ui.dart';

/// A small filled circle holding an icon, such as the arrow at the end of a
/// Home section title. It grows while held. The tap area is a full
/// [AppSizes.button] square around the circle.
class AppCircleFilledButton extends StatelessWidget {
  const new({
    required this.icon,
    required this.semanticLabel,
    this.onPressed,
    super.key,
  });

  final IconData icon;

  /// What a screen reader says, since the button shows no text.
  final String semanticLabel;

  /// `null` disables the button.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: semanticLabel,
      excludeSemantics: true,
      onTap: onPressed,
      child: AppPressGrow(
        onTap: onPressed,
        child: SizedBox.square(
          dimension: AppSizes.button,
          child: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colors.surface,
                shape: BoxShape.circle,
              ),
              child: SizedBox.square(
                dimension: AppSizes.circleButton,
                child: Icon(
                  icon,
                  size: AppSizes.circleButtonIcon,
                  color: colors.ink,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
