import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

/// A 240° arc that opens at the bottom, around the coffee cup. The [fill]
/// part grows clockwise from the bottom left over `progress.value`.
class CoffeeArcPainter extends CustomPainter {
  const new({
    required this.progress,
    required this.track,
    required this.fill,
    required this.stroke,
  }) : super(repaint: progress);

  final Animation<double> progress;
  final Color track;
  final Color fill;
  final double stroke;

  /// Starts at 7 o'clock, measured clockwise from 3 o'clock.
  static const double _start = math.pi * 5 / 6;
  static const double _span = math.pi * 4 / 3;

  @override
  void paint(Canvas canvas, Size size) {
    final side = size.shortestSide;
    final square = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: side,
      height: side,
    );
    final rect = square.deflate(stroke / 2);
    canvas.drawArc(rect, _start, _span, false, _line(track));
    final sweep = progress.value.clamp(0.0, 1.0) * _span;
    if (sweep > 0) canvas.drawArc(rect, _start, sweep, false, _line(fill));
  }

  Paint _line(Color color) => Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = stroke
    ..strokeCap = StrokeCap.round;

  @override
  bool shouldRepaint(CoffeeArcPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.track != track ||
      oldDelegate.fill != fill ||
      oldDelegate.stroke != stroke;
}
