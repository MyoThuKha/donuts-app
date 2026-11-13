import 'dart:math' as math;
import 'dart:ui' show lerpDouble;

import 'package:material_ui/material_ui.dart';

/// Draws the registration progress ring and, on the last step, the check it
/// morphs into.
class StepProgressPainter extends CustomPainter {
  new({
    required this.sweep,
    required this.check,
    required this.from,
    required this.to,
    required this.track,
    required this.arc,
    required this.mark,
  }) : super(repaint: Listenable.merge([sweep, check]));

  /// Ring thickness as a share of its diameter: the design draws a thick
  /// two-colour donut rather than a thin arc.
  static const double strokeShare = 0.26;

  /// Check stroke as a share of the diameter.
  static const double _checkShare = 0.1;

  /// Check points as fractions of the ring's size.
  static const List<Offset> _checkPoints = [
    Offset(0.28, 0.52),
    Offset(0.44, 0.67),
    Offset(0.72, 0.36),
  ];

  final Animation<double> sweep;
  final Animation<double> check;
  final double from;
  final double to;
  final Color track;
  final Color arc;
  final Color mark;

  double get progress => lerpDouble(from, to, sweep.value)!;

  double get checkProgress => check.value;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final strokeWidth = size.shortestSide * strokeShare;
    final ring = rect.deflate(strokeWidth / 2);
    // Butt caps: the design's arc ends square against the track.
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas
      ..drawOval(ring, stroke..color = track)
      ..drawArc(
        ring,
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        stroke..color = arc,
      );
    if (checkProgress > 0) _paintCheck(canvas, size);
  }

  void _paintCheck(Canvas canvas, Size size) {
    canvas.drawOval(
      Offset.zero & size,
      Paint()..color = arc.withValues(alpha: checkProgress),
    );
    final path = Path()
      ..moveTo(
        _checkPoints[0].dx * size.width,
        _checkPoints[0].dy * size.height,
      );
    for (final point in _checkPoints.skip(1)) {
      path.lineTo(point.dx * size.width, point.dy * size.height);
    }
    final metric = path.computeMetrics().first;
    canvas.drawPath(
      metric.extractPath(0, metric.length * checkProgress),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = size.shortestSide * _checkShare
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = mark,
    );
  }

  @override
  bool shouldRepaint(StepProgressPainter oldDelegate) =>
      from != oldDelegate.from ||
      to != oldDelegate.to ||
      track != oldDelegate.track ||
      arc != oldDelegate.arc ||
      mark != oldDelegate.mark;
}
