import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:donuts/features/rewards/presentation/painters/quarter_clipper.dart';
import 'package:material_ui/material_ui.dart';

/// The donut challenge art: the same image twice. The bottom copy is
/// greyed and lightened, and the top copy shows through a sector that
/// grows clockwise from 12 o'clock with [progress].
class DonutQuartersWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final image = AppNetworkImage(
      url: url,
      asset: asset,
      fit: BoxFit.contain,
      cacheWidth: cacheWidth,
    );
    return RepaintBoundary(
      child: Stack(
        fit: StackFit.expand,
        children: [
          ColorFiltered(colorFilter: _faded, child: image),
          AnimatedBuilder(
            animation: progress,
            builder: (context, child) =>
                ClipPath(clipper: QuarterClipper(progress.value), child: child),
            child: image,
          ),
        ],
      ),
    );
  }
}
