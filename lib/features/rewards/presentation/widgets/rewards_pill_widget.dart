import 'package:donuts/core/format/number_format.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
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
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: colors.highlight,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(RewardsDimens.pillHeight / 2),
            ),
          ),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: RewardsDimens.pillHeight,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.m,
              AppSpacing.xs,
              AppSpacing.s,
              AppSpacing.xs,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpacing.xs,
              children: [
                Text(
                  context.l10n.rewardsPill,
                  style: context.text.body.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                ScaleTransition(scale: badge, child: _Badge(count)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const new(this.count);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: RewardsDimens.badgeSize,
        minHeight: RewardsDimens.badgeSize,
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: context.colors.surface,
        shape: const StadiumBorder(),
      ),
      child: Text(formatGrouped(count), style: context.text.label),
    );
  }
}
