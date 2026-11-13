import 'package:material_ui/material_ui.dart';

/// A vertical line between two tier shields, [filled] from the top down to
/// `fill.value` of its height and [track] below that.
class TierLinePainter extends CustomPainter {
  const new({required this.fill, required this.track, required this.filled})
    : super(repaint: fill);

  final Animation<double> fill;
  final Color track;
  final Color filled;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = Radius.circular(size.width / 2);
    final whole = Offset.zero & size;
    canvas.drawRRect(
      RRect.fromRectAndRadius(whole, radius),
      Paint()..color = track,
    );
    final height = size.height * fill.value.clamp(0.0, 1.0);
    if (height <= 0) return;
    final done = Rect.fromLTWH(0, 0, size.width, height);
    canvas.drawRRect(
      RRect.fromRectAndRadius(done, radius),
      Paint()..color = filled,
    );
  }

  @override
  bool shouldRepaint(TierLinePainter oldDelegate) =>
      oldDelegate.fill != fill ||
      oldDelegate.track != track ||
      oldDelegate.filled != filled;
}
