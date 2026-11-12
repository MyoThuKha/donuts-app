import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

/// The points ring: a full [track] circle with a [fill] arc from 12 o'clock,
/// clockwise, over `progress.value` of the circle. Short [sprinkle] dashes
/// sit on the filled part, like sprinkles on a donut.
class PointsRingPainter extends CustomPainter {
  const new({
    required this.progress,
    required this.track,
    required this.fill,
    required this.stroke,
    this.sprinkle,
  }) : super(repaint: progress);

  final Animation<double> progress;
  final Color track;
  final Color fill;
  final double stroke;

  /// Colour of the dashes on the filled arc. Null draws none.
  final Color? sprinkle;

  static const double _start = -math.pi / 2;
  static const double _sprinkleLength = 0.2;
  static const double _sprinkleWidth = 0.07;
  static const double _sprinkleAlpha = 0.8;

  /// Fixed positions, so every frame draws the same sprinkles.
  static final List<_Sprinkle> _sprinkles = _Sprinkle.seeded();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = (Offset.zero & size).deflate(stroke / 2);
    canvas.drawArc(rect, 0, math.pi * 2, false, _line(track));
    final sweep = progress.value.clamp(0.0, 1.0) * math.pi * 2;
    if (sweep <= 0) return;
    canvas.drawArc(rect, _start, sweep, false, _line(fill));
    if (sprinkle case final color?) _paintSprinkles(canvas, rect, sweep, color);
  }

  Paint _line(Color color) => Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeWidth = stroke
    ..strokeCap = StrokeCap.round;

  void _paintSprinkles(Canvas canvas, Rect rect, double sweep, Color color) {
    final paint = Paint()
      ..color = color.withValues(alpha: _sprinkleAlpha)
      ..strokeWidth = stroke * _sprinkleWidth
      ..strokeCap = StrokeCap.round;
    final half = stroke * _sprinkleLength / 2;
    for (final s in _sprinkles) {
      final angle = s.turn * math.pi * 2;
      if (angle > sweep) continue;
      final centre = _onRing(rect, _start + angle, s.radial * stroke);
      final dir = Offset(math.cos(s.tilt), math.sin(s.tilt)) * half;
      canvas.drawLine(centre - dir, centre + dir, paint);
    }
  }

  Offset _onRing(Rect rect, double angle, double offset) {
    final radius = rect.width / 2 + offset;
    return rect.center + Offset(math.cos(angle), math.sin(angle)) * radius;
  }

  @override
  bool shouldRepaint(PointsRingPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.track != track ||
      oldDelegate.fill != fill ||
      oldDelegate.stroke != stroke ||
      oldDelegate.sprinkle != sprinkle;
}

/// One dash: where it sits around the ring and across it, and its angle.
class _Sprinkle {
  const new(this.turn, this.radial, this.tilt);

  static const int _count = 22;
  static const int _seed = 7;
  static const double _spread = 0.6;

  /// Share of the circle from 12 o'clock, 0 to 1.
  final double turn;

  /// Offset across the stroke, as a share of the stroke width.
  final double radial;
  final double tilt;

  static List<_Sprinkle> seeded() {
    final random = math.Random(_seed);
    return [
      for (var i = 0; i < _count; i++)
        _Sprinkle(
          (i + random.nextDouble()) / _count,
          (random.nextDouble() - 0.5) * _spread,
          random.nextDouble() * math.pi,
        ),
    ];
  }
}
