import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:material_ui/material_ui.dart';

/// Paints the donut challenge's full-colour photo inside a pie sector that
/// starts at 12 o'clock and grows clockwise over `progress.value`. It sits
/// on a faded copy of the same photo, so the donut colours in by quarters.
///
/// The photo is drawn the way `Image(fit: BoxFit.contain)` draws it, so it
/// lines up with the faded copy underneath. Until [image] has decoded it
/// paints nothing and the faded copy, or its placeholder, shows alone.
class DonutQuartersPainter extends CustomPainter {
  const new({required this.progress, required this.image})
    : super(repaint: progress);

  final Animation<double> progress;
  final ui.Image? image;

  /// 12 o'clock, measured clockwise from 3 o'clock.
  static const double _start = -math.pi / 2;

  @override
  void paint(Canvas canvas, Size size) {
    final image = this.image;
    final share = progress.value.clamp(0.0, 1.0);
    if (image == null || share <= 0) return;
    final box = Offset.zero & size;
    canvas.save();
    if (share < 1) canvas.clipPath(sector(box, share));
    paintImage(canvas: canvas, rect: box, image: image, fit: BoxFit.contain);
    canvas.restore();
  }

  /// The part of [box] that [share] of a full turn covers, from 12 o'clock
  /// clockwise. Its arc runs past the corners, so the sector reaches the
  /// box's edges. A full share is the whole box.
  @visibleForTesting
  static Path sector(Rect box, double share) {
    if (share >= 1) return Path()..addRect(box);
    final centre = box.center;
    final reach = Rect.fromCircle(center: centre, radius: box.longestSide);
    return Path()
      ..moveTo(centre.dx, centre.dy)
      ..arcTo(reach, _start, share * math.pi * 2, false)
      ..close();
  }

  @override
  bool shouldRepaint(DonutQuartersPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.image != image;
}
