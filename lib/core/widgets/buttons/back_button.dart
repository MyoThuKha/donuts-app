import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// The white rounded square with an arrow from the registration designs.
class AppBackButton extends StatelessWidget {
  const new({this.onPressed, super.key});

  static const double boxSize = 40;
  static const double iconSize = 20;

  /// Defaults to popping the current route.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      button: true,
      label: context.l10n.back,
      excludeSemantics: true,
      child: InkResponse(
        onTap: onPressed ?? () => context.pop(),
        radius: AppSizes.button / 2,
        child: SizedBox.square(
          dimension: AppSizes.button,
          child: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(AppRadii.field),
              ),
              child: SizedBox.square(
                dimension: boxSize,
                child: Icon(
                  LucideIcons.arrowLeft,
                  size: iconSize,
                  color: colors.inkMuted,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
