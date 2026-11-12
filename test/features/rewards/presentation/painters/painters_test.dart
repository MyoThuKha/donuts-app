import 'package:donuts/features/rewards/presentation/painters/coffee_arc_painter.dart';
import 'package:donuts/features/rewards/presentation/painters/points_ring_painter.dart';
import 'package:donuts/features/rewards/presentation/painters/quarter_clipper.dart';
import 'package:donuts/features/rewards/presentation/painters/shield_painter.dart';
import 'package:donuts/features/rewards/presentation/painters/tier_line_painter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

const _track = Color(0xFFF1F3F3);
const _fill = Color(0xFFE87BAC);
const _other = Color(0xFFF3984B);
const _letter = TextStyle(fontSize: 14, color: Color(0xFF878787));

Future<void> _paint(WidgetTester tester, CustomPainter painter) async {
  await tester.pumpWidget(
    Center(
      child: SizedBox.square(
        dimension: 200,
        child: CustomPaint(painter: painter),
      ),
    ),
  );
}

void main() {
  const progress = AlwaysStoppedAnimation<double>(0.75);

  PointsRingPainter ring({Color fill = _fill, double stroke = 40}) =>
      PointsRingPainter(
        progress: progress,
        track: _track,
        fill: fill,
        stroke: stroke,
      );

  CoffeeArcPainter arc({Color fill = _other, double stroke = 8}) =>
      CoffeeArcPainter(
        progress: progress,
        track: _track,
        fill: fill,
        stroke: stroke,
      );

  TierLinePainter line({Color filled = _fill}) =>
      TierLinePainter(fill: progress, track: _track, filled: filled);

  ShieldPainter shield({Color fill = _fill, int stars = 1}) => ShieldPainter(
    fill: fill,
    stars: stars,
    letter: 'S',
    letterStyle: _letter,
  );

  group('painters repaint only when their values change', () {
    test('the points ring', () {
      expect(ring().shouldRepaint(ring()), isFalse);
      expect(ring(fill: _other).shouldRepaint(ring()), isTrue);
      expect(ring(stroke: 20).shouldRepaint(ring()), isTrue);
    });

    test('the coffee arc', () {
      expect(arc().shouldRepaint(arc()), isFalse);
      expect(arc(fill: _fill).shouldRepaint(arc()), isTrue);
      expect(arc(stroke: 4).shouldRepaint(arc()), isTrue);
    });

    test('the tier line', () {
      expect(line().shouldRepaint(line()), isFalse);
      expect(line(filled: _other).shouldRepaint(line()), isTrue);
    });

    test('the shield', () {
      expect(shield().shouldRepaint(shield()), isFalse);
      expect(shield(fill: _other).shouldRepaint(shield()), isTrue);
      expect(shield(stars: 2).shouldRepaint(shield()), isTrue);
    });

    test('the quarter clipper', () {
      expect(
        const QuarterClipper(0.25).shouldReclip(const QuarterClipper(0.25)),
        isFalse,
      );
      expect(
        const QuarterClipper(0.5).shouldReclip(const QuarterClipper(0.25)),
        isTrue,
      );
    });
  });

  test('the quarter clipper covers a quarter of the box at 0.25', () {
    final path = const QuarterClipper(0.25).getClip(const Size(100, 100));

    expect(path.contains(const Offset(75, 25)), isTrue);
    expect(path.contains(const Offset(25, 75)), isFalse);
    expect(path.contains(const Offset(25, 25)), isFalse);
  });

  test('the quarter clipper covers nothing at 0 and everything at 1', () {
    const size = Size(100, 100);

    expect(
      const QuarterClipper(0).getClip(size).contains(const Offset(75, 25)),
      isFalse,
    );
    expect(
      const QuarterClipper(1).getClip(size).contains(const Offset(25, 75)),
      isTrue,
    );
  });

  testWidgets('the ring painter paints without errors at 0, 0.75 and 1', (
    tester,
  ) async {
    for (final value in [0.0, 0.75, 1.0]) {
      await _paint(
        tester,
        PointsRingPainter(
          progress: AlwaysStoppedAnimation(value),
          track: _track,
          fill: _fill,
          stroke: 40,
          sprinkle: const Color(0xFFFFFFFF),
        ),
      );
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('the shield, tier line and coffee arc paint without errors', (
    tester,
  ) async {
    for (final painter in <CustomPainter>[shield(stars: 3), line(), arc()]) {
      await _paint(tester, painter);
      expect(tester.takeException(), isNull);
    }
  });
}
