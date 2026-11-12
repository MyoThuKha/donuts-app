import 'package:donuts/core/theme/donuts_colors.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/images/donut_placeholder.dart';
import 'package:material_ui/material_ui.dart';

/// One donut in a tinted circle. Centre and diameter are fractions of the
/// hero's width and height, so the layout scales from 4.7" to 6.9" phones.
/// The donut is a [DonutPlaceholder] until the generated photos arrive.
typedef HeroCircle = ({
  Offset center,
  double diameter,
  Color Function(DonutsColors c) tint,
  Color Function(DonutsColors c) glaze,
});

/// Circle tint strength over the gradient background.
const double _tintAlpha = 0.45;

/// The donut circles behind the onboarding title, as in design screen 1.
final List<HeroCircle> onboardingCircles = [
  (
    center: const Offset(0.04, 0.08),
    diameter: 0.46,
    tint: (c) => c.primary,
    glaze: (c) => c.inkMuted,
  ),
  (
    center: const Offset(0.98, 0.06),
    diameter: 0.34,
    tint: (c) => c.accent,
    glaze: (c) => c.inkMuted,
  ),
  (
    center: const Offset(0.5, 0.34),
    diameter: 0.58,
    tint: (c) => c.highlight,
    glaze: (c) => c.accent,
  ),
  (
    center: const Offset(0.02, 0.6),
    diameter: 0.4,
    tint: (c) => c.bannerIndigo,
    glaze: (c) => c.bannerIndigo,
  ),
  (
    center: const Offset(0.98, 0.56),
    diameter: 0.4,
    tint: (c) => c.primary,
    glaze: (c) => c.accent,
  ),
  (
    center: const Offset(0.5, 0.9),
    diameter: 0.5,
    tint: (c) => c.highlight,
    glaze: (c) => c.highlight,
  ),
];

class OnboardingHeroView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            for (final circle in onboardingCircles)
              _positioned(context, circle, size),
            const Positioned.fill(child: _BottomFade()),
          ],
        );
      },
    );
  }

  Widget _positioned(BuildContext context, HeroCircle circle, Size size) {
    final diameter = circle.diameter * size.width;
    return Positioned(
      left: circle.center.dx * size.width - diameter / 2,
      top: circle.center.dy * size.height - diameter / 2,
      width: diameter,
      height: diameter,
      child: HeroCircleItem(circle: circle),
    );
  }
}

class HeroCircleItem extends StatelessWidget {
  const new({required this.circle, super.key});

  /// Share of the circle the donut fills.
  static const double donutShare = 0.72;

  final HeroCircle circle;

  @override
  Widget build(BuildContext context) {
    final tint = circle.tint(context.colors).withValues(alpha: _tintAlpha);
    return DecoratedBox(
      decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
      child: FractionallySizedBox(
        widthFactor: donutShare,
        heightFactor: donutShare,
        child: DonutPlaceholder(glaze: circle.glaze(context.colors)),
      ),
    );
  }
}

/// Fades the lowest circles into the background behind the title, as the
/// design does.
class _BottomFade extends StatelessWidget {
  const new();

  /// Where the fade starts, as a share of the hero's height.
  static const double fadeStart = 0.55;

  @override
  Widget build(BuildContext context) {
    final background = context.colors.authBottom;
    return IgnorePointer(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [fadeStart, 1],
            colors: [background.withValues(alpha: 0), background],
          ),
        ),
      ),
    );
  }
}
