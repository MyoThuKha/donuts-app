import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/text/rolling_number.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// A grey stadium with a white rim, with minus and plus buttons around a
/// rolling quantity. A null callback disables its button.

class QuantityStepper extends StatelessWidget {
  const new({
    required this.quantity,
    this.onDecrement,
    this.onIncrement,
    super.key,
  });

  final int quantity;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;
  static const double height = 52;

  /// The visible circle of a button. Its tap area is larger.
  static const double _button = 34;
  static const double _tapTarget = 44;
  static const double _icon = 18;

  /// The white outline around the stepper.
  static const double _rim = 3;

  /// Wide enough for "99" in the title style, so the buttons don't shift.
  static const double _numberWidth = 40;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: colors.canvas,
        shape: StadiumBorder(
          side: BorderSide(color: colors.surface, width: _rim),
        ),
      ),
      child: SizedBox(
        height: QuantityStepper.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _StepperButton(
                icon: LucideIcons.minus,
                label: l10n.productDecrease,
                onPressed: onDecrement,
              ),
              SizedBox(
                width: _numberWidth,
                child: Center(
                  child: RollingNumber(
                    value: quantity,
                    style: context.text.title,
                  ),
                ),
              ),
              _StepperButton(
                icon: LucideIcons.plus,
                label: l10n.productIncrease,
                onPressed: onIncrement,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const new({required this.icon, required this.label, this.onPressed});

  final IconData icon;
  final String label;
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
      child: InkResponse(
        onTap: onPressed,
        radius: QuantityStepper._tapTarget / 2,
        child: SizedBox.square(
          dimension: QuantityStepper._tapTarget,
          child: Center(
            child: DecoratedBox(
              // Blue at the limit too, as the design draws it; the
              // semantics still report the button as disabled.
              decoration: ShapeDecoration(
                color: colors.primary,
                shape: const CircleBorder(),
              ),
              child: SizedBox.square(
                dimension: QuantityStepper._button,
                child: Icon(
                  icon,
                  size: QuantityStepper._icon,
                  color: colors.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
