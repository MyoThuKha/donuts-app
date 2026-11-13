import 'dart:ui' show lerpDouble;

import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/rewards/presentation/blocs/rewards_state.dart';
import 'package:donuts/features/rewards/presentation/rewards_dimens.dart';
import 'package:material_ui/material_ui.dart';

/// "Eat more earn more" and "Gift" as two separate pills with white rims,
/// centred on the seam between the white top and grey bottom of the page.
/// The selected pill is blue with white bold text, the other grey with ink
/// text. Both follow [controller]'s animation, so a swipe between the
/// lists recolours them as it goes.
class RewardsTabsView extends StatelessWidget {
  const new({required this.controller, required this.onSelected, super.key});

  final TabController controller;
  final ValueChanged<RewardsTab> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final position = controller.animation!;
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSpacing.s,
          children: [
            for (final tab in RewardsTab.values)
              Flexible(
                child: AnimatedBuilder(
                  animation: position,
                  builder: (context, _) => _TabPill(
                    label: switch (tab) {
                      RewardsTab.challenges => l10n.rewardsTabChallenges,
                      RewardsTab.gifts => l10n.rewardsTabGifts,
                    },
                    // 1 when this tab is selected, 0 when the other is.
                    selection: (1 - (position.value - tab.index).abs()).clamp(
                      0.0,
                      1.0,
                    ),
                    onTap: () => onSelected(tab),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TabPill extends StatelessWidget {
  const new({
    required this.label,
    required this.selection,
    required this.onTap,
  });

  final String label;

  /// How selected the pill is, from 0 to 1, for mid-swipe colours.
  final double selection;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final selected = selection > 0.5;
    final style = context.text.sectionTitle.copyWith(
      color: Color.lerp(colors.ink, colors.onPrimary, selection),
      fontWeight: FontWeight.lerp(FontWeight.w500, FontWeight.w700, selection),
    );
    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: DecoratedBox(
          decoration: ShapeDecoration(
            color: Color.lerp(colors.canvas, colors.primary, selection),
            shape: StadiumBorder(
              side: BorderSide(
                color: colors.surface,
                width: RewardsDimens.tabRim,
              ),
            ),
          ),
          child: SizedBox(
            height: RewardsDimens.tabHeight,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: lerpDouble(AppSpacing.l, AppSpacing.xl, selection)!,
              ),
              child: Center(
                widthFactor: 1,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(label, maxLines: 1, style: style),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
