import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/press_grow.dart';
import 'package:material_ui/material_ui.dart';

/// A compact white stadium with the label in capitals, such as Home's
/// Explore now. It sizes to its label and grows while held.
class AppPillButton extends StatelessWidget {
  const new({required this.label, this.onPressed, super.key});

  final String label;

  /// `null` disables the button.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
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
            color: colors.surface,
            shape: const StadiumBorder(),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.l,
              vertical: AppSpacing.s,
            ),
            child: Text(
              label.toUpperCase(),
              style: context.text.button.copyWith(color: colors.primary),
            ),
          ),
        ),
      ),
    );
  }
}
