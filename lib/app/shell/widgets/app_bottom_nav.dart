import 'package:donuts/app/shell/widgets/nav_pill_widget.dart';
import 'package:donuts/app/shell/widgets/stretchy_position_widget.dart';
import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:material_ui/material_ui.dart';

typedef AppNavItem = ({IconData icon, String label});

/// Bottom bar whose accent pill slides to the active tab and widens to show
/// its label.
class AppBottomNav extends StatelessWidget {
  const new({
    required this.currentIndex,
    required this.onSelected,
    required this.items,
    super.key,
  });

  /// Share of the bar's inner width the active pill takes.
  static const double pillShare = 0.36;

  /// Gap between the pill and the bar's top and bottom edges.
  static const double pillInset = 12;

  static const double iconSize = 24;

  final int currentIndex;
  final ValueChanged<int> onSelected;
  final List<AppNavItem> items;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadii.nav),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppSizes.navBar,
          child: LayoutBuilder(
            builder: (context, constraints) =>
                _buildSlots(context, constraints.maxWidth),
          ),
        ),
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
          top: pillInset,
          bottom: pillInset,
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
              Icon(item.icon, color: color, size: AppBottomNav.iconSize),
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
        padding: const EdgeInsets.only(left: AppSpacing.xs),
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
              style: context.text.label.copyWith(color: color),
            ),
          ),
        ),
      ),
    );
  }
}
