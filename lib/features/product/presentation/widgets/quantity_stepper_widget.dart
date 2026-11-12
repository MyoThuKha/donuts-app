import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/product/presentation/product_dimens.dart';
import 'package:donuts/features/product/presentation/widgets/rolling_number_widget.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// A white stadium with minus and plus buttons around a rolling quantity.
/// A null callback disables its button.
class QuantityStepperWidget extends StatelessWidget {
  const new({
    required this.quantity,
    this.onDecrement,
    this.onIncrement,
    super.key,
  });

  final int quantity;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: context.colors.surface,
        shape: const StadiumBorder(),
      ),
      child: SizedBox(
        height: ProductDimens.stepperHeight,
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
                width: ProductDimens.stepperNumberWidth,
                child: Center(
                  child: RollingNumberWidget(
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
      child: InkResponse(
        onTap: onPressed,
        radius: ProductDimens.stepperTapTarget / 2,
        child: SizedBox.square(
          dimension: ProductDimens.stepperTapTarget,
          child: Center(
            child: DecoratedBox(
              decoration: ShapeDecoration(
                color: onPressed == null ? colors.disabled : colors.primary,
                shape: const CircleBorder(),
              ),
              child: SizedBox.square(
                dimension: ProductDimens.stepperButton,
                child: Icon(
                  icon,
                  size: ProductDimens.stepperIcon,
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
