import 'package:donuts/core/widgets/images/blended_fit_image.dart';
import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:material_ui/material_ui.dart';

/// An [AppNetworkImage] whose drawn picture has [radius] corners.
///
/// A full photo shows whole with rounded corners. A transparent cut-out
/// looks unchanged, because the rounding only trims empty pixels. While
/// the image loads, and when it fails, the plain [AppNetworkImage] shows
/// with its placeholder, asset fallback or error tile.
///
/// [toFit] and [progress] let a Hero ease the picture from [fit]'s size to
/// [toFit]'s.
class RoundedNetworkImage extends StatelessWidget {
  const new({
    required this.url,
    required this.radius,
    this.asset,
    this.fit = BoxFit.contain,
    this.toFit,
    this.progress = 0,
    this.cacheWidth,
    this.fade = true,
    this.placeholderColor,
    this.placeholderShape = const RoundedRectangleBorder(),
    this.fallback,
    super.key,
  });

  final String? url;
  final String? asset;
  final double radius;
  final BoxFit fit;
  final BoxFit? toFit;
  final double progress;

  /// Decode width in physical pixels, as [AppNetworkImage.cacheWidth].
  final int? cacheWidth;
  final bool fade;
  final Color? placeholderColor;

  /// As [AppNetworkImage.placeholderShape].
  final ShapeBorder placeholderShape;

  /// As [AppNetworkImage.fallback].
  final Widget? fallback;

  @override
  Widget build(BuildContext context) {
    final image = AppNetworkImage(
      url: url,
      asset: asset,
      fit: fit,
      cacheWidth: cacheWidth,
      fade: fade,
      placeholderColor: placeholderColor,
      placeholderShape: placeholderShape,
      fallback: fallback,
    );
    final provider = AppNetworkImage.provider(
      url: url,
      asset: asset,
      cacheWidth: cacheWidth,
    );
    if (provider == null) return image;
    return BlendedFitImage(
      image: provider,
      fallbackImage: url == null
          ? null
          : AppNetworkImage.provider(asset: asset, cacheWidth: cacheWidth),
      from: fit,
      to: toFit,
      t: progress,
      radius: radius,
      placeholder: image,
    );
  }
}
