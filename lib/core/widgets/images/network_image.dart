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
/// error tile on failure.
class AppNetworkImage extends StatelessWidget {
  const new({
    required this.url,
    this.asset,
    this.fit = BoxFit.cover,
    this.cacheWidth,
    this.cacheManager,
    super.key,
  });

  static const Key placeholderKey = ValueKey('app-network-image-placeholder');
  static const Key errorKey = ValueKey('app-network-image-error');

  final String? url;
  final String? asset;
  final BoxFit fit;

  /// Decode width in physical pixels, to keep large photos out of memory.
  final int? cacheWidth;
  final BaseCacheManager? cacheManager;

  @override
  Widget build(BuildContext context) {
    final url = this.url;
    if (url == null) return _assetOr(const _PlaceholderBox());
    return CachedNetworkImage(
      imageUrl: url,
      cacheManager: cacheManager,
      memCacheWidth: cacheWidth,
      fit: fit,
      placeholder: (_, _) => _assetOr(const _PlaceholderBox()),
      errorWidget: (_, _, _) => _assetOr(const _ErrorTile()),
    );
  }

  Widget _assetOr(Widget fallback) {
    final asset = this.asset;
    if (asset == null) return fallback;
    return Image.asset(
      asset,
      fit: fit,
      cacheWidth: cacheWidth,
      errorBuilder: (_, _, _) => const _PlaceholderBox(),
    );
  }
}

class _PlaceholderBox extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) => ColoredBox(
    key: AppNetworkImage.placeholderKey,
    color: context.colors.canvas,
    child: const SizedBox.expand(),
  );
}

class _ErrorTile extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) => Semantics(
    key: AppNetworkImage.errorKey,
    label: context.l10n.imageUnavailable,
    image: true,
    child: ColoredBox(
      color: context.colors.canvas,
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
