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
/// error tile on failure, both in [placeholderColor].
class AppNetworkImage extends StatelessWidget {
  const new({
    required this.url,
    this.asset,
    this.fit = BoxFit.cover,
    this.cacheWidth,
    this.cacheManager,
    this.fade = true,
    this.placeholderColor,
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

  @override
  Widget build(BuildContext context) {
    final url = this.url;
    if (url == null) return _assetOr(_PlaceholderBox(placeholderColor));
    return CachedNetworkImage(
      imageUrl: url,
      cacheManager: cacheManager,
      memCacheWidth: cacheWidth,
      fit: fit,
      fadeInDuration: fade ? _fadeIn : Duration.zero,
      fadeOutDuration: fade ? _fadeOut : Duration.zero,
      placeholder: (_, _) => _assetOr(_PlaceholderBox(placeholderColor)),
      errorWidget: (_, _, _) => _assetOr(_ErrorTile(placeholderColor)),
    );
  }

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
          frame == null ? _PlaceholderBox(placeholderColor) : child,
      errorBuilder: (_, _, _) => _PlaceholderBox(placeholderColor),
    );
  }
}

class _PlaceholderBox extends StatelessWidget {
  const new(this.color);

  final Color? color;

  @override
  Widget build(BuildContext context) => ColoredBox(
    key: AppNetworkImage.placeholderKey,
    color: color ?? context.colors.canvas,
    child: const SizedBox.expand(),
  );
}

class _ErrorTile extends StatelessWidget {
  const new(this.color);

  final Color? color;

  @override
  Widget build(BuildContext context) => Semantics(
    key: AppNetworkImage.errorKey,
    label: context.l10n.imageUnavailable,
    image: true,
    child: ColoredBox(
      color: color ?? context.colors.canvas,
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
