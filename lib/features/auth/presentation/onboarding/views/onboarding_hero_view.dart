import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/motion/stagger.dart';
import 'package:donuts/core/widgets/effects/progressive_fade.dart';
import 'package:donuts/features/auth/presentation/auth_assets.dart';
import 'package:material_ui/material_ui.dart';

/// One donut photo in a circle. Centre and diameter are fractions of the
/// hero's width and height, so the layout scales from 4.7" to 6.9" phones.
typedef HeroCircle = ({Offset center, double diameter, String image});

/// The donut circles behind the onboarding title, as in design screen 1.
/// Four photos fill six circles, so the two repeats sit far apart.
const List<HeroCircle> onboardingCircles = [
  (center: Offset(0.04, 0.08), diameter: 0.46, image: AuthAssets.stripedDonut),
  (
    center: Offset(0.98, 0.06),
    diameter: 0.34,
    image: AuthAssets.chocolateDonut,
  ),
  (center: Offset(0.5, 0.34), diameter: 0.58, image: AuthAssets.sprinkledDonut),
  (center: Offset(0.02, 0.6), diameter: 0.4, image: AuthAssets.purpleDonut),
  (center: Offset(0.98, 0.56), diameter: 0.4, image: AuthAssets.stripedDonut),
  (center: Offset(0.5, 0.9), diameter: 0.5, image: AuthAssets.chocolateDonut),
];

class OnboardingHeroView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        // The lowest circles fade into the background behind the title.
        return ProgressiveFade(
          start: _fadeStart,
          child: Stack(
            children: [
              for (final (i, circle) in onboardingCircles.indexed)
                _positioned(context, i, circle, size),
            ],
          ),
        );
      },
    );
  }

  Widget _positioned(
    BuildContext context,
    int index,
    HeroCircle circle,
    Size size,
  ) {
    final diameter = circle.diameter * size.width;
    return Positioned(
      left: circle.center.dx * size.width - diameter / 2,
      top: circle.center.dy * size.height - diameter / 2,
      width: diameter,
      height: diameter,
      child: StaggeredEntrance(
        index: index,
        from: _driftFrom(circle.center),
        duration: AppMotion.showcase,
        curve: AppMotion.emphasized,
        child: HeroCircleItem(circle: circle),
      ),
    );
  }

  /// Circles near an edge drift in from that edge; the middle ones rise
  /// from below. Offsets are in circle diameters.
  static Offset _driftFrom(Offset center) {
    if (center.dx < _edgeZone) return const Offset(-_drift, _rise);
    if (center.dx > 1 - _edgeZone) return const Offset(_drift, _rise);
    return const Offset(0, _drift);
  }

  /// Where the fade starts, as a share of the hero's height.
  static const double _fadeStart = 0.55;

  static const double _edgeZone = 0.3;
  static const double _drift = 0.7;
  static const double _rise = 0.15;
}

class HeroCircleItem extends StatelessWidget {
  const new({required this.circle, super.key});

  /// How far the photo is enlarged inside the circle, so the donut fills
  /// it as in the design.
  static const double zoom = 1.6;

  final HeroCircle circle;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Transform.scale(
        scale: zoom,
        child: Image.asset(
          circle.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          excludeFromSemantics: true,
        ),
      ),
    );
  }
}
