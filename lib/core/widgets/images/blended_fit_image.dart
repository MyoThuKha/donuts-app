import 'package:material_ui/material_ui.dart';

/// Paints [image] centred in its box at a size eased from the size [from]
/// gives it to the size [to] gives it, clipped to the part inside the box
/// with [radius] corners.
///
/// At [t] 0 it looks the same as `Image(fit: from)`, and at 1 the same as
/// `Image(fit: to)`. A Hero uses it to move a photo between a tile that
/// crops it ([BoxFit.cover]) and a frame that shows it whole
/// ([BoxFit.contain]) without a jump when the flight starts or lands.
///
/// The clip follows the picture, not the box: a photo letterboxed by a
/// contain fit gets rounded corners of its own. A transparent cut-out
/// loses only empty pixels, so its rounding can't be seen.
///
/// The image's size is needed to work out both fits. While [image] has no
/// picture yet, or after it fails, [fallbackImage] is drawn the same way,
/// such as a bundled copy on an offline first launch. [placeholder] shows
/// only while neither has a picture.
class BlendedFitImage extends StatefulWidget {
  const new({
    required this.image,
    required this.from,
    required this.placeholder,
    BoxFit? to,
    this.fallbackImage,
    this.t = 0,
    this.radius = 0,
    super.key,
  }) : to = to ?? from;

  final ImageProvider image;

  /// Drawn while [image] has no picture or fails to load.
  final ImageProvider? fallbackImage;
  final BoxFit from;
  final BoxFit to;

  /// 0 paints the image at [from]'s size, 1 at [to]'s.
  final double t;

  /// Corner radius of the visible picture.
  final double radius;
  final Widget placeholder;

  @override
  State<BlendedFitImage> createState() => _BlendedFitImageState();
}

class _BlendedFitImageState extends State<BlendedFitImage> {
  final _main = _ImageSubscription();
  final _fallback = _ImageSubscription();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolve();
  }

  @override
  void didUpdateWidget(BlendedFitImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.image != oldWidget.image ||
        widget.fallbackImage != oldWidget.fallbackImage) {
      _resolve();
    }
  }

  @override
  void dispose() {
    _main.dispose();
    _fallback.dispose();
    super.dispose();
  }

  /// Resolves [BlendedFitImage.image], and the fallback too unless the main
  /// image came out of the cache at once, so a cached photo costs no
  /// second decode.
  void _resolve() {
    final configuration = createLocalImageConfiguration(context);
    _main.listen(
      widget.image.resolve(configuration),
      onImage: _onImage,
      onError: _resolveFallback,
    );
    if (_main.info == null) _resolveFallback();
  }

  void _resolveFallback() {
    final fallback = widget.fallbackImage;
    if (fallback == null || !mounted) return;
    _fallback.listen(
      fallback.resolve(createLocalImageConfiguration(context)),
      onImage: _onImage,
    );
  }

  void _onImage() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final image = _main.info?.image ?? _fallback.info?.image;
    if (image == null) return widget.placeholder;
    final source = Size(image.width.toDouble(), image.height.toDouble());
    return LayoutBuilder(
      builder: (context, constraints) {
        final box = constraints.biggest;
        final painted = Size.lerp(
          _paintedSize(widget.from, source, box),
          _paintedSize(widget.to, source, box),
          widget.t,
        )!;
        final visible = Size(
          painted.width.clamp(0, box.width),
          painted.height.clamp(0, box.height),
        );
        return Center(
          child: SizedBox.fromSize(
            size: visible,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.radius),
              child: OverflowBox(
                minWidth: painted.width,
                maxWidth: painted.width,
                minHeight: painted.height,
                maxHeight: painted.height,
                child: RawImage(image: image, fit: BoxFit.fill),
              ),
            ),
          ),
        );
      },
    );
  }

  /// The whole image's size when [fit] draws it in [box]. A cover fit
  /// draws a cropped part of the image at the box's size, so the scale
  /// comes from that part and applies to the whole image.
  static Size _paintedSize(BoxFit fit, Size source, Size box) {
    final fitted = applyBoxFit(fit, source, box);
    return Size(
      source.width * fitted.destination.width / fitted.source.width,
      source.height * fitted.destination.height / fitted.source.height,
    );
  }
}

/// One image stream and the latest picture it delivered.
class _ImageSubscription {
  ImageStream? _stream;
  ImageStreamListener? _listener;
  ImageInfo? info;

  /// Listens to [stream] unless it is the one already followed.
  void listen(
    ImageStream stream, {
    required VoidCallback onImage,
    VoidCallback? onError,
  }) {
    if (stream.key == _stream?.key) return;
    _unlisten();
    final listener = ImageStreamListener((image, _) {
      info?.dispose();
      info = image;
      onImage();
    }, onError: (_, _) => onError?.call());
    _stream = stream..addListener(listener);
    _listener = listener;
  }

  void _unlisten() {
    final listener = _listener;
    if (listener != null) _stream?.removeListener(listener);
  }

  void dispose() {
    _unlisten();
    info?.dispose();
  }
}
