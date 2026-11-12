import 'dart:math' as math;

import 'package:donuts/core/theme/theme_context.dart';
import 'package:material_ui/material_ui.dart';

/// A donut drawn in code. It stands in for product photos until the real
/// images arrive, so no throwaway image files enter the repo.
class DonutPlaceholder extends StatelessWidget {
  const new({required this.glaze, super.key});

  final Color glaze;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ExcludeSemantics(
      child: CustomPaint(
        size: Size.infinite,
        painter: _DonutPainter(
          dough: Color.lerp(colors.highlight, colors.surface, _doughLightness)!,
          glaze: glaze,
          sprinkles: colors.surface,
        ),
      ),
    );
  }

  static const double _doughLightness = 0.35;
}

class _DonutPainter extends CustomPainter {
  new({required this.dough, required this.glaze, required this.sprinkles});

  /// Ring radii as shares of half the shortest side.
  static const double _outer = 1;
  static const double _glazeOuter = 0.92;
  static const double _glazeInner = 0.42;
  static const double _hole = 0.34;
  static const int _sprinkleCount = 14;
  static const double _sprinkleRadius = 0.035;

  final Color dough;
  final Color glaze;
  final Color sprinkles;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final unit = size.shortestSide / 2;
    _ring(canvas, center, unit * _outer, unit * _hole, dough);
    _ring(canvas, center, unit * _glazeOuter, unit * _glazeInner, glaze);
    final dot = Paint()..color = sprinkles;
    final orbit = unit * (_glazeOuter + _glazeInner) / 2;
    for (var i = 0; i < _sprinkleCount; i++) {
      final angle = 2 * math.pi * i / _sprinkleCount;
      final wobble = i.isEven ? 1.08 : 0.9;
      canvas.drawCircle(
        center + Offset.fromDirection(angle, orbit * wobble),
        unit * _sprinkleRadius,
        dot,
      );
    }
  }

  void _ring(
    Canvas canvas,
    Offset center,
    double outer,
    double inner,
    Color c,
  ) {
    final path = Path()
      ..fillType = PathFillType.evenOdd
      ..addOval(Rect.fromCircle(center: center, radius: outer))
      ..addOval(Rect.fromCircle(center: center, radius: inner));
    canvas.drawPath(path, Paint()..color = c);
  }

  @override
  bool shouldRepaint(_DonutPainter oldDelegate) =>
      dough != oldDelegate.dough ||
      glaze != oldDelegate.glaze ||
      sprinkles != oldDelegate.sprinkles;
}
