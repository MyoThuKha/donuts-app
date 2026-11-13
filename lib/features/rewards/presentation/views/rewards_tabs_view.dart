import 'dart:ui' show lerpDouble;

import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/rewards/presentation/blocs/rewards_state.dart';
import 'package:donuts/features/rewards/presentation/rewards_dimens.dart';
import 'package:material_ui/material_ui.dart';

/// "Eat more earn more" and "Gift" as two grey pills with white rims,
/// centred on the seam between the white top and grey bottom of the page.
///
/// One blue pill, the indicator, sits behind the selected label. It slides
/// and stretches from one pill to the other with [controller]'s animation,
/// so it follows a swipe between the lists as well as a tap. The labels
/// recolour as it passes.
class RewardsTabsView extends StatelessWidget {
  const new({required this.controller, required this.onSelected, super.key});

  final TabController controller;
  final ValueChanged<RewardsTab> onSelected;

  /// The blue indicator pill, for tests.
  static const Key indicatorKey = ValueKey('rewards-tab-indicator');

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
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
        child: CustomMultiChildLayout(
          delegate: _TabsLayout(position),
          children: [
            for (final tab in RewardsTab.values)
              LayoutId(
                id: (_Layer.track, tab),
                child: _Pill(color: colors.canvas),
              ),
            LayoutId(
              id: _Layer.indicator,
              child: _Pill(key: indicatorKey, color: colors.primary),
            ),
            for (final tab in RewardsTab.values)
              LayoutId(
                id: (_Layer.label, tab),
                child: AnimatedBuilder(
                  animation: position,
                  builder: (context, _) => _TabLabel(
                    label: _labelOf(context, tab),
                    selection: _selectionOf(tab, position.value),
                    onTap: () => onSelected(tab),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  static String _labelOf(BuildContext context, RewardsTab tab) => switch (tab) {
    RewardsTab.challenges => context.l10n.rewardsTabChallenges,
    RewardsTab.gifts => context.l10n.rewardsTabGifts,
  };

  /// 1 when [tab] is selected, 0 when the other is, in between mid-swipe.
  static double _selectionOf(RewardsTab tab, double position) =>
      (1 - (position - tab.index).abs()).clamp(0.0, 1.0);
}

enum _Layer { track, indicator, label }

/// Sizes each label to its text, puts the grey track under it, and places
/// the indicator between the two labels' outlines by the tab animation's
/// [position]: on the first at 0, on the second at 1.
class _TabsLayout extends MultiChildLayoutDelegate {
  new(this.position) : super(relayout: position);

  final Animation<double> position;

  @override
  Size getSize(BoxConstraints constraints) =>
      Size(constraints.maxWidth, RewardsDimens.tabHeight);

  @override
  void performLayout(Size size) {
    const tabs = RewardsTab.values;
    // Each label may take half the row after the gap, as a Flexible would.
    final maxWidth = (size.width - AppSpacing.s * (tabs.length - 1)) / 2;
    final labelSizes = [
      for (final tab in tabs)
        layoutChild((
          _Layer.label,
          tab,
        ), BoxConstraints.loose(Size(maxWidth, size.height))),
    ];
    final rowWidth =
        labelSizes.fold<double>(0, (sum, s) => sum + s.width) +
        AppSpacing.s * (tabs.length - 1);
    var x = (size.width - rowWidth) / 2;
    final rects = <Rect>[];
    for (final (i, tab) in tabs.indexed) {
      final rect = Offset(x, 0) & labelSizes[i];
      rects.add(rect);
      positionChild((_Layer.label, tab), rect.topLeft);
      layoutChild((_Layer.track, tab), BoxConstraints.tight(rect.size));
      positionChild((_Layer.track, tab), rect.topLeft);
      x = rect.right + AppSpacing.s;
    }
    _placeIndicator(rects);
  }

  void _placeIndicator(List<Rect> rects) {
    final at = position.value.clamp(0.0, (rects.length - 1).toDouble());
    final from = at.floor();
    final to = at.ceil();
    final rect = Rect.lerp(rects[from], rects[to], at - from)!;
    layoutChild(_Layer.indicator, BoxConstraints.tight(rect.size));
    positionChild(_Layer.indicator, rect.topLeft);
  }

  @override
  bool shouldRelayout(_TabsLayout oldDelegate) =>
      oldDelegate.position != position;
}

/// A stadium in [color] with the white rim both pills share.
class _Pill extends StatelessWidget {
  const new({required this.color, super.key});

  final Color color;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: ShapeDecoration(
      color: color,
      shape: StadiumBorder(
        side: BorderSide(
          color: context.colors.surface,
          width: RewardsDimens.tabRim,
        ),
      ),
    ),
  );
}

class _TabLabel extends StatelessWidget {
  const new({
    required this.label,
    required this.selection,
    required this.onTap,
  });

  final String label;

  /// How selected the tab is, from 0 to 1, for mid-swipe colours.
  final double selection;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final text = context.text;
    final style = TextStyle.lerp(text.sectionTitle, text.tabActive, selection);
    return Semantics(
      button: true,
      selected: selection > 0.5,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
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
    );
  }
}
