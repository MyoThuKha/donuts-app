import 'dart:ui' show lerpDouble;

import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/badges/app_tag.dart';
import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:donuts/core/widgets/images/rounded_network_image.dart';
import 'package:material_ui/material_ui.dart';

/// A product photo inside the Hero that flies between a Home tile and
/// Product detail.
///
/// Both ends use this widget, so the flight carries the same backing,
/// fit and decoded image the whole way:
/// - The white backing and the rounded clip sit inside the Hero. When they
///   sat outside, the tile showed a white hole while the photo was away.
///   The backing shows while the image loads or is missing too, so a tile
///   is never an empty gap.
/// - A cut-out product uses [BoxFit.contain] with an [inset], so none of
///   it is cut off. A seasonal box photo uses [BoxFit.cover] and fills its
///   tile. Product detail shows every photo whole with [BoxFit.contain].
///   Seasonal photos are landscape, so the two fits draw them at different
///   sizes, and the flight eases between them through [toFit].
/// - On Product detail the drawn picture has [pictureRadius] corners, the
///   tile's radius, so a photo shows whole and rounded. A cut-out's
///   corners are transparent, so its rounding can't be seen.
/// - Both ends decode at [decodeWidth], so landing reuses the image the
///   tile already decoded instead of decoding a second size.
/// - The photo doesn't fade in. Flutter rebuilds the Home end's image
///   when a pop lands, and a fade there flashes the backing.
class ProductHeroImage extends StatelessWidget {
  const new({
    required this.url,
    required this.asset,
    this.radius = 0,
    this.fit = BoxFit.contain,
    this.inset = 0,
    this.toFit,
    this.progress = 0,
    this.pictureRadius = 0,
    super.key,
  });

  /// Decode width in physical pixels. Wide enough for the detail frame on
  /// the largest phone at 3x, and shared by every product image.
  static const int decodeWidth = 800;

  /// The Home tile's corner radius: concentric with the discount pill
  /// [AppSpacing.s] in from the tile's corner, so it follows the pill when
  /// the text size changes. Every tile uses it, with or without a badge,
  /// so a row's corners match, and Product detail rounds its photo with it
  /// so the corners keep their curve through the flight.
  static double tileRadius(BuildContext context) =>
      AppRadii.enclosing(AppTag.heightOf(context) / 2, AppSpacing.s);

  final String? url;
  final String? asset;

  /// Corner radius: the tile's radius on Home, 0 on Product detail.
  final double radius;

  final BoxFit fit;

  /// Share of the box's width and height left blank on each side, so a
  /// cut-out product sits in the middle of its white card.
  final double inset;

  /// Set only in flight when the two ends use different fits: the fit at
  /// Product detail. The photo's size eases from [fit]'s at [progress] 0
  /// to [toFit]'s at 1.
  final BoxFit? toFit;
  final double progress;

  /// Corner radius of the drawn picture: [tileRadius] on Product detail
  /// and in flight, 0 on Home, where the tile's own clip rounds it.
  final double pictureRadius;

  @override
  Widget build(BuildContext context) {
    final surface = context.colors.surface;
    final share = 1 - 2 * inset;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: ColoredBox(
        color: surface,
        child: FractionallySizedBox(
          widthFactor: share,
          heightFactor: share,
          child: _image(surface),
        ),
      ),
    );
  }

  Widget _image(Color surface) {
    final toFit = this.toFit;
    if (pictureRadius == 0 && (toFit == null || toFit == fit)) {
      return AppNetworkImage(
        url: url,
        asset: asset,
        fit: fit,
        cacheWidth: decodeWidth,
        fade: false,
        placeholderColor: surface,
      );
    }
    return RoundedNetworkImage(
      url: url,
      asset: asset,
      radius: pictureRadius,
      fit: fit,
      toFit: toFit,
      progress: progress,
      cacheWidth: decodeWidth,
      fade: false,
      placeholderColor: surface,
    );
  }
}

/// Flies a [ProductHeroImage] between the tile and Product detail, easing
/// the corner radius, the inset and the photo's size from the tile's to
/// the detail's.
///
/// The photo comes from the Home end, which always has the product, even
/// while Product detail is still loading.
Widget productHeroShuttle(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection direction,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  final from = (fromHeroContext.widget as Hero).child;
  final to = (toHeroContext.widget as Hero).child;
  // The animation runs from Home (0) to Product detail (1) on both push
  // and pop, so the Home end is the source on a push and the target on a pop.
  final (home, detail) = direction == HeroFlightDirection.push
      ? (from, to)
      : (to, from);
  // An end that isn't a ProductHeroImage has no radius to ease, so the
  // Home end's child flies as it is.
  if (home is! ProductHeroImage || detail is! ProductHeroImage) return home;
  return AnimatedBuilder(
    animation: animation,
    builder: (context, _) => ProductHeroImage(
      url: home.url,
      asset: home.asset,
      radius: lerpDouble(home.radius, detail.radius, animation.value)!,
      fit: home.fit,
      inset: lerpDouble(home.inset, detail.inset, animation.value)!,
      toFit: detail.fit,
      progress: animation.value,
      pictureRadius: detail.pictureRadius,
    ),
  );
}
