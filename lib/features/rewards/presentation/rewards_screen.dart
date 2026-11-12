import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:material_ui/material_ui.dart';

/// Rewards (screen 10). A stub until branch 6 builds it.
class RewardsScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.canvas,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.pageGutter),
          child: Text(
            context.l10n.placeholderComingSoon(context.l10n.tabReward),
            style: context.text.sectionTitle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
