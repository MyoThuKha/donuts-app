import 'package:cached_network_image/cached_network_image.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// A network image cached on disk, so it still shows offline once loaded.
///
/// While it loads, and when the download fails, it shows the bundled
/// [asset]. Without an asset it shows a plain box while loading and an
/// error tile on failure, both in [placeholderColor] and [placeholderShape].
class AppNetworkImage extends StatelessWidget {
  const new({
    required this.url,
    this.asset,
    this.fit = BoxFit.cover,
    this.cacheWidth,
    this.cacheManager,
    this.fade = true,
    this.placeholderColor,
    this.placeholderShape = const RoundedRectangleBorder(),
    super.key,
  });

  static const Key placeholderKey = ValueKey('app-network-image-placeholder');
  static const Key errorKey = ValueKey('app-network-image-error');

  // cached_network_image's own defaults.
  static const Duration _fadeIn = Duration(milliseconds: 500);
  static const Duration _fadeOut = Duration(milliseconds: 1000);

  final String? url;
  final String? asset;
  final BoxFit fit;

  /// Decode width in physical pixels, to keep large photos out of memory.
  final int? cacheWidth;
  final BaseCacheManager? cacheManager;

  /// Whether the photo fades in over the placeholder. Off for a Hero's
  /// image: Flutter rebuilds it when the flight lands, and a fresh fade
  /// there shows as a flash.
  final bool fade;

  /// Fill of the loading box and the error tile. Defaults to the canvas
  /// grey; a photo on a white card passes white so the card stays visible.
  final Color? placeholderColor;

  /// Outline of the loading box and the error tile, so a stand-in matches
  /// the shape the real image draws, such as a circle for a round badge.
  /// The image itself is never clipped. Defaults to a square box.
  final ShapeBorder placeholderShape;

  @override
  Widget build(BuildContext context) {
    final url = this.url;
    if (url == null) return _assetOr(_placeholder());
    return CachedNetworkImage(
      imageUrl: url,
      cacheManager: cacheManager,
      memCacheWidth: cacheWidth,
      fit: fit,
      fadeInDuration: fade ? _fadeIn : Duration.zero,
      fadeOutDuration: fade ? _fadeOut : Duration.zero,
      placeholder: (_, _) => _assetOr(_placeholder()),
      errorWidget: (_, _, _) =>
          _assetOr(_ErrorTile(placeholderColor, placeholderShape)),
    );
  }

  Widget _placeholder() => _PlaceholderBox(placeholderColor, placeholderShape);

  Widget _assetOr(Widget fallback) {
    final asset = this.asset;
    if (asset == null) return fallback;
    return Image.asset(
      asset,
      fit: fit,
      cacheWidth: cacheWidth,
      // Until the first frame decodes, Image paints nothing, and whatever
      // sits behind it shows for a frame. A cached asset decodes at once.
      frameBuilder: (_, child, frame, _) =>
          frame == null ? _placeholder() : child,
      errorBuilder: (_, _, _) => _placeholder(),
    );
  }
}

class _PlaceholderBox extends StatelessWidget {
  const new(this.color, this.shape);

  final Color? color;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    key: AppNetworkImage.placeholderKey,
    decoration: ShapeDecoration(
      color: color ?? context.colors.canvas,
      shape: shape,
    ),
    child: const SizedBox.expand(),
  );
}

class _ErrorTile extends StatelessWidget {
  const new(this.color, this.shape);

  final Color? color;
  final ShapeBorder shape;

  @override
  Widget build(BuildContext context) => Semantics(
    key: AppNetworkImage.errorKey,
    label: context.l10n.imageUnavailable,
    image: true,
    child: DecoratedBox(
      decoration: ShapeDecoration(
        color: color ?? context.colors.canvas,
        shape: shape,
      ),
      child: Center(
        child: Icon(
          LucideIcons.imageOff,
          size: AppSizes.imageErrorIcon,
          color: context.colors.inkSubtle,
        ),
      ),
    ),
  );
}
