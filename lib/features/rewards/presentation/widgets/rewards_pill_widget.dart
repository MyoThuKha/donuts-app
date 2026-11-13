import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/badges/app_tag.dart';
import 'package:donuts/core/widgets/badges/edge_tag.dart';
import 'package:donuts/features/rewards/presentation/rewards_dimens.dart';
import 'package:material_ui/material_ui.dart';

/// The orange "Rewards" stadium flush with the right edge, with a white
/// badge holding [count]. The badge scales in with [badge].
class RewardsPill extends StatelessWidget {
  const new({required this.count, required this.badge, super.key});

  final int count;
  final Animation<double> badge;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      label: context.l10n.rewardsAvailable(count),
      excludeSemantics: true,
      child: EdgeTag(
        color: colors.highlight,
        height: RewardsDimens.pillHeight,
        // A short run past the badge, as the design draws it.
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.xl,
          AppSpacing.xs,
          AppSpacing.s,
          AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: AppSpacing.s,
          children: [
            Text(context.l10n.rewardsPill, style: context.text.badge),
            ScaleTransition(
              scale: badge,
              child: AppTag.count(
                count: count,
                diameter: RewardsDimens.badgeSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
