import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

/// A tier badge: a [fill] shield with 1 to 3 stars and the tier's [letter],
/// both drawn in `letterStyle.color`.
class ShieldPainter extends CustomPainter {
  const new({
    required this.fill,
    required this.stars,
    required this.letter,
    required this.letterStyle,
  });

  final Color fill;
  final int stars;
  final String letter;
  final TextStyle letterStyle;

  static const int _maxStars = 3;
  static const double _starRow = 0.3;
  static const double _starRadius = 0.09;
  static const double _starGap = 0.21;
  static const double _starInner = 0.45;
  static const int _starPoints = 5;
  static const double _letterCentre = 0.6;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(_shield(size), Paint()..color = fill);
    final ink = Paint()..color = letterStyle.color ?? fill;
    final count = stars.clamp(1, _maxStars);
    final y = size.height * _starRow;
    for (var i = 0; i < count; i++) {
      final x = size.width * (0.5 + (i - (count - 1) / 2) * _starGap);
      canvas.drawPath(_star(Offset(x, y), size.width * _starRadius), ink);
    }
    _paintLetter(canvas, size);
  }

  /// Rounded shoulders at the top, curving to a point at the bottom.
  Path _shield(Size s) => Path()
    ..moveTo(s.width * 0.5, 0)
    ..quadraticBezierTo(
      s.width * 0.8,
      s.height * 0.08,
      s.width,
      s.height * 0.14,
    )
    ..lineTo(s.width, s.height * 0.5)
    ..quadraticBezierTo(
      s.width * 0.95,
      s.height * 0.85,
      s.width * 0.5,
      s.height,
    )
    ..quadraticBezierTo(s.width * 0.05, s.height * 0.85, 0, s.height * 0.5)
    ..lineTo(0, s.height * 0.14)
    ..quadraticBezierTo(s.width * 0.2, s.height * 0.08, s.width * 0.5, 0)
    ..close();

  Path _star(Offset centre, double radius) {
    final path = Path();
    for (var i = 0; i < _starPoints * 2; i++) {
      final r = i.isEven ? radius : radius * _starInner;
      final angle = -math.pi / 2 + i * math.pi / _starPoints;
      final point = centre + Offset(math.cos(angle), math.sin(angle)) * r;
      i == 0
          ? path.moveTo(point.dx, point.dy)
          : path.lineTo(point.dx, point.dy);
    }
    return path..close();
  }

  void _paintLetter(Canvas canvas, Size size) {
    final text = TextPainter(
      text: TextSpan(text: letter, style: letterStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    final centre = Offset(size.width / 2, size.height * _letterCentre);
    text
      ..paint(canvas, centre - Offset(text.width / 2, text.height / 2))
      ..dispose();
  }

  @override
  bool shouldRepaint(ShieldPainter oldDelegate) =>
      oldDelegate.fill != fill ||
      oldDelegate.stars != stars ||
      oldDelegate.letter != letter ||
      oldDelegate.letterStyle != letterStyle;
}
