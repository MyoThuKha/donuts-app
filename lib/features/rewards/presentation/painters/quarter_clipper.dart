import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

/// Clips to a pie sector from 12 o'clock, clockwise, covering [fraction] of
/// the turn. Callers snap the fraction to quarters for the donut challenge.
class QuarterClipper extends CustomClipper<Path> {
  const new(this.fraction);

  final double fraction;

  @override
  Path getClip(Size size) {
    final share = fraction.clamp(0.0, 1.0);
    if (share <= 0) return Path();
    if (share >= 1) return Path()..addRect(Offset.zero & size);
    final centre = size.center(Offset.zero);
    // Reaches past the corners, so the sector covers the whole box.
    final reach = Rect.fromCircle(center: centre, radius: size.longestSide);
    return Path()
      ..moveTo(centre.dx, centre.dy)
      ..arcTo(reach, -math.pi / 2, share * math.pi * 2, false)
      ..close();
  }

  @override
  bool shouldReclip(QuarterClipper oldClipper) =>
      oldClipper.fraction != fraction;
}
