import 'package:donuts/core/motion/app_motion.dart';
import 'package:material_ui/material_ui.dart';

/// The backdrop for a member's tier: a tinted wash with that tier's hexagon
/// on the right. Home's member panel and the Settings header sit on it.
///
/// It cross-fades when the tier changes. [color] shows underneath whenever
/// there is no image: while the member loads, for a tier without art, or if
/// the image fails.
class TierBackdrop extends StatelessWidget {
  const new({
    required this.tierId,
    required this.color,
    this.alignment = Alignment.topRight,
    super.key,
  });

  final String? tierId;
  final Color color;

  /// Which part of the image shows when it is cropped. Top right keeps the
  /// hexagon's star in view; a short band that needs the star out of the
  /// way of its content anchors at the bottom.
  final Alignment alignment;

  /// The bundled backdrop for [tierId], or null for no tier or a tier
  /// without its own art.
  static String? assetFor(String? tierId) => switch (tierId) {
    'silver' => 'assets/images/home_header_silver.jpg',
    'gold' => 'assets/images/home_header_gold.jpg',
    'platinum' => 'assets/images/home_header_platinum.jpg',
    _ => null,
  };

  @override
  Widget build(BuildContext context) {
    final asset = assetFor(tierId);
    return ColoredBox(
      color: color,
      child: AnimatedSwitcher(
        duration: context.motion.of(AppMotion.medium),
        child: asset == null
            ? const SizedBox.expand()
            : DecoratedBox(
                key: ValueKey(asset),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(asset),
                    fit: BoxFit.cover,
                    alignment: alignment,
                    // A missing image leaves the colour showing.
                    onError: (_, _) {},
                  ),
                ),
                child: const SizedBox.expand(),
              ),
      ),
    );
  }
}
