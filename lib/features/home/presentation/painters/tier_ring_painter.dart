import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

/// The member's progress to the next tier, as an arc just outside the
/// avatar. It grows clockwise from 12 o'clock, has round ends, and shades
/// from [start] to [end] along its length, so the tip is always [end].
///
/// It paints outside its box: the box is the avatar, and the ring sits
/// [gap] beyond the avatar's edge.
class TierRingPainter extends CustomPainter {
  const new({
    required this.progress,
    required this.start,
    required this.end,
    required this.stroke,
    required this.gap,
  });

  /// Share of a full turn, 0 to 1.
  final double progress;
  final Color start;
  final Color end;
  final double stroke;
  final double gap;

  static const double _top = -math.pi / 2;
  static const double _turn = math.pi * 2;

  @override
  void paint(Canvas canvas, Size size) {
    final sweep = progress.clamp(0.0, 1.0) * _turn;
    if (sweep <= 0) return;
    final radius = size.shortestSide / 2 + gap + stroke / 2;
    final rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: radius,
    );
    // A round end reaches half the stroke past each end of the arc. The
    // gradient starts that far before 12 o'clock, so the first end is
    // [start] too, instead of wrapping round to [end].
    final cap = stroke / 2 / radius;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        endAngle: sweep + cap * 2,
        colors: [start, end],
        transform: GradientRotation(_top - cap),
      ).createShader(rect);
    canvas.drawArc(rect, _top, sweep, false, paint);
  }

  @override
  bool shouldRepaint(TierRingPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.start != start ||
      oldDelegate.end != end ||
      oldDelegate.stroke != stroke ||
      oldDelegate.gap != gap;
}
