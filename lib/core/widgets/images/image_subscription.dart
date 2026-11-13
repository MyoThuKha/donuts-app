import 'package:material_ui/material_ui.dart';

/// One image stream and the latest picture it delivered, for a widget that
/// paints a decoded image itself instead of through an `Image` widget.
class ImageSubscription {
  ImageStream? _stream;
  ImageStreamListener? _listener;

  /// The latest picture, or null until the stream delivers one.
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
