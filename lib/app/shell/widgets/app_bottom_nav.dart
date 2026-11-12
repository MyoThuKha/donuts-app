import 'package:donuts/app/shell/widgets/nav_pill_widget.dart';
import 'package:donuts/app/shell/widgets/stretchy_position_widget.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';

/// A tab: its SVG icon (see `NavIcons`) and label.
typedef AppNavItem = ({String icon, String label});

/// The bottom bar as the design draws it: a blue panel with rounded top
/// corners and a white rim, inset from the screen sides, over a pink band
/// that runs edge to edge behind its lower half. The accent pill slides to
/// the active tab and widens to show its label.
class AppBottomNav extends StatelessWidget {
  const new({
    required this.currentIndex,
    required this.onSelected,
    required this.items,
    super.key,
  });

  /// Share of the panel's inner width the active pill takes.
  static const double pillShare = 0.28;

  /// Height of the active pill.
  static const double pillHeight = 50;

  static const double iconSize = 22;

  /// Corner radius of the panel's top corners.
  static const double panelRadius = 28;

  /// The white outline around the panel and the pill.
  static const double rim = 1.5;

  final int currentIndex;
  final ValueChanged<int> onSelected;
  final List<AppNavItem> items;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return SizedBox(
      height: AppSizes.navBar + bottomInset,
      child: Stack(
        children: [
          // The pink band behind the panel's lower half, edge to edge.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: AppSizes.navBar / 2 + bottomInset,
            child: ColoredBox(color: colors.accent),
          ),
          // The panel runs a rim's width past the bottom, so its outline
          // shows only on the top and sides.
          Positioned(
            left: AppSpacing.pageGutter,
            right: AppSpacing.pageGutter,
            top: 0,
            bottom: -rim,
            child: DecoratedBox(
              decoration: ShapeDecoration(
                color: colors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(panelRadius),
                  ),
                  side: BorderSide(color: colors.onPrimary, width: rim),
                ),
              ),
            ),
          ),
          Positioned(
            left: AppSpacing.pageGutter,
            right: AppSpacing.pageGutter,
            top: 0,
            height: AppSizes.navBar,
            child: LayoutBuilder(
              builder: (context, constraints) =>
                  _buildSlots(context, constraints.maxWidth),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlots(BuildContext context, double barWidth) {
    final layout = _NavLayout(
      innerWidth: barWidth - 2 * AppSpacing.l,
      count: items.length,
      selected: currentIndex,
    );
    final duration = context.motion.of(AppMotion.medium);
    return Stack(
      children: [
        StretchyPositionWidget(
          duration: duration,
          curve: AppMotion.emphasized,
          left: AppSpacing.l + layout.leftOf(currentIndex),
          width: layout.pillWidth,
          top: (AppSizes.navBar - pillHeight) / 2,
          bottom: (AppSizes.navBar - pillHeight) / 2,
          child: const NavPillWidget(),
        ),
        for (var i = 0; i < items.length; i++)
          AnimatedPositioned(
            duration: duration,
            curve: AppMotion.emphasized,
            left: AppSpacing.l + layout.leftOf(i),
            width: layout.widthOf(i),
            top: 0,
            bottom: 0,
            child: _NavItem(
              item: items[i],
              selected: i == currentIndex,
              onTap: () => onSelected(i),
            ),
          ),
      ],
    );
  }
}

/// Horizontal positions of the slots: the active one is pill-wide, the rest
/// share the remaining width equally.
class _NavLayout {
  new({required double innerWidth, required int count, required this.selected})
    : pillWidth = innerWidth * AppBottomNav.pillShare,
      slotWidth = innerWidth * (1 - AppBottomNav.pillShare) / (count - 1);

  final int selected;
  final double pillWidth;
  final double slotWidth;

  double widthOf(int index) => index == selected ? pillWidth : slotWidth;

  double leftOf(int index) =>
      index * slotWidth + (index > selected ? pillWidth - slotWidth : 0);
}

class _NavItem extends StatelessWidget {
  const new({required this.item, required this.selected, required this.onTap});

  final AppNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = context.colors.onPrimary;
    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      onTap: onTap,
      excludeSemantics: true,
      child: InkResponse(
        onTap: onTap,
        radius: AppSizes.button / 2,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: AppSizes.button,
            minHeight: AppSizes.button,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                item.icon,
                key: ValueKey(item.icon),
                width: AppBottomNav.iconSize,
                height: AppBottomNav.iconSize,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
              if (selected) _label(context, color),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(BuildContext context, Color color) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(left: AppSpacing.s),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: context.motion.of(AppMotion.fast),
          curve: AppMotion.standard,
          builder: (context, opacity, child) =>
              Opacity(opacity: opacity, child: child),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              item.label,
              maxLines: 1,
              style: context.text.label.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
