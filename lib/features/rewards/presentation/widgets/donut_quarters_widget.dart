import 'package:donuts/core/widgets/images/image_subscription.dart';
import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:donuts/features/rewards/presentation/painters/donut_quarters_painter.dart';
import 'package:donuts/features/rewards/presentation/widgets/reward_card_widget.dart';
import 'package:material_ui/material_ui.dart';

/// The donut challenge art. The bottom layer is the photo greyed and
/// lightened, through the shared image widget with its cache, bundled
/// fallback and placeholder. On top, [DonutQuartersPainter] paints the
/// full-colour photo inside a sector that grows with [progress].
///
/// The painter reads the same decoded image the bottom layer shows: the
/// download when it has one, else the bundled [asset].
class DonutQuartersWidget extends StatefulWidget {
  const new({
    required this.progress,
    required this.url,
    required this.asset,
    required this.cacheWidth,
    super.key,
  });

  final Animation<double> progress;
  final String? url;
  final String? asset;
  final int cacheWidth;

  @override
  State<DonutQuartersWidget> createState() => _DonutQuartersWidgetState();
}

class _DonutQuartersWidgetState extends State<DonutQuartersWidget> {
  final _main = ImageSubscription();
  final _fallback = ImageSubscription();

  /// Luminance weights, scaled down and lifted towards white.
  static const double _keep = 0.55;
  static const double _lift = 0.45 * 255;
  static const double _r = 0.2126 * _keep;
  static const double _g = 0.7152 * _keep;
  static const double _b = 0.0722 * _keep;
  static const ColorFilter _faded = ColorFilter.matrix([
    _r, _g, _b, 0, _lift, //
    _r, _g, _b, 0, _lift, //
    _r, _g, _b, 0, _lift, //
    0, 0, 0, 1, 0, //
  ]);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolve();
  }

  @override
  void didUpdateWidget(DonutQuartersWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.url != oldWidget.url ||
        widget.asset != oldWidget.asset ||
        widget.cacheWidth != oldWidget.cacheWidth) {
      _resolve();
    }
  }

  @override
  void dispose() {
    _main.dispose();
    _fallback.dispose();
    super.dispose();
  }

  /// Resolves the download, and the bundled asset too unless the download
  /// came out of the cache at once.
  void _resolve() {
    final main = AppNetworkImage.provider(
      url: widget.url,
      asset: widget.asset,
      cacheWidth: widget.cacheWidth,
    );
    if (main == null) return;
    _main.listen(
      main.resolve(createLocalImageConfiguration(context)),
      onImage: _onImage,
      onError: _resolveFallback,
    );
    if (_main.info == null) _resolveFallback();
  }

  void _resolveFallback() {
    if (widget.url == null || !mounted) return;
    final asset = AppNetworkImage.provider(
      asset: widget.asset,
      cacheWidth: widget.cacheWidth,
    );
    if (asset == null) return;
    _fallback.listen(
      asset.resolve(createLocalImageConfiguration(context)),
      onImage: _onImage,
    );
  }

  void _onImage() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        foregroundPainter: DonutQuartersPainter(
          progress: widget.progress,
          image: _main.info?.image ?? _fallback.info?.image,
        ),
        child: SizedBox.expand(
          child: ColorFiltered(
            colorFilter: _faded,
            child: AppNetworkImage(
              url: widget.url,
              asset: widget.asset,
              fit: BoxFit.contain,
              placeholderShape: RewardCard.artPlaceholderShape,
              cacheWidth: widget.cacheWidth,
            ),
          ),
        ),
      ),
    );
  }
}
