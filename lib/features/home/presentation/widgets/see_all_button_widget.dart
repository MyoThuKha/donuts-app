import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/home/presentation/home_dimens.dart';
import 'package:donuts/features/home/presentation/widgets/press_scale_widget.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// The chevron at the end of a section title. Press feedback only.
class SeeAllButtonWidget extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      button: true,
      label: context.l10n.homeSeeAll,
      excludeSemantics: true,
      child: PressScaleWidget(
        child: SizedBox.square(
          dimension: kMinInteractiveDimension,
          child: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: colors.surface,
                shape: BoxShape.circle,
              ),
              child: SizedBox.square(
                dimension: HomeDimens.seeAllButton,
                child: Icon(
                  LucideIcons.chevronRight,
                  size: HomeDimens.seeAllIcon,
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
