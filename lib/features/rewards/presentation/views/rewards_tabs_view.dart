import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/rewards/presentation/blocs/rewards_state.dart';
import 'package:donuts/features/rewards/presentation/rewards_dimens.dart';
import 'package:material_ui/material_ui.dart';

/// "Eat more earn more" and "Gift" in a white bar that sits across the
/// white top and grey bottom of the page. The blue indicator slides to
/// the selected [tab].
class RewardsTabsView extends StatelessWidget {
  const new({required this.tab, required this.onSelected, super.key});

  final RewardsTab tab;
  final ValueChanged<RewardsTab> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            colors.surface,
            colors.surface,
            colors.canvas,
            colors.canvas,
          ],
          stops: const [0, 0.5, 0.5, 1],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pageGutter),
        child: Center(child: IntrinsicWidth(child: _bar(context))),
      ),
    );
  }

  Widget _bar(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: colors.surface,
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(RewardsDimens.tabBarInset),
        child: Stack(
          children: [
            Positioned.fill(child: _indicator(context)),
            Row(
              children: [
                _tab(context, RewardsTab.challenges, l10n.rewardsTabChallenges),
                _tab(context, RewardsTab.gifts, l10n.rewardsTabGifts),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _indicator(BuildContext context) => AnimatedAlign(
    alignment: tab == RewardsTab.challenges
        ? Alignment.centerLeft
        : Alignment.centerRight,
    duration: context.motion.of(AppMotion.medium),
    curve: AppMotion.emphasized,
    child: FractionallySizedBox(
      widthFactor: 0.5,
      heightFactor: 1,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: context.colors.primary,
          shape: const StadiumBorder(),
        ),
      ),
    ),
  );

  Widget _tab(BuildContext context, RewardsTab value, String label) {
    final selected = value == tab;
    final style = context.text.sectionTitle.copyWith(
      color: selected ? context.colors.onPrimary : context.colors.inkSubtle,
    );
    return Expanded(
      child: Semantics(
        button: true,
        selected: selected,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onSelected(value),
          child: SizedBox(
            height: RewardsDimens.tabHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: AnimatedDefaultTextStyle(
                    style: style,
                    duration: context.motion.of(AppMotion.medium),
                    child: Text(label, maxLines: 1),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
