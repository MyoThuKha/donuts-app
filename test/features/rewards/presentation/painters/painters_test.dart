import 'package:donuts/features/rewards/presentation/painters/coffee_arc_painter.dart';
import 'package:donuts/features/rewards/presentation/painters/donut_quarters_painter.dart';
import 'package:donuts/features/rewards/presentation/painters/points_ring_painter.dart';
import 'package:donuts/features/rewards/presentation/painters/tier_line_painter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

const _track = Color(0xFFF1F3F3);
const _fill = Color(0xFFE87BAC);
const _other = Color(0xFFF3984B);
const _box = Rect.fromLTWH(0, 0, 100, 100);

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

    test('the donut quarters', () {
      const quarter = AlwaysStoppedAnimation<double>(0.25);
      const painter = DonutQuartersPainter(progress: quarter, image: null);

      expect(
        painter.shouldRepaint(
          const DonutQuartersPainter(progress: quarter, image: null),
        ),
        isFalse,
      );
      expect(
        painter.shouldRepaint(
          const DonutQuartersPainter(progress: progress, image: null),
        ),
        isTrue,
      );
    });
  });

  test('the donut sector covers a quarter of the box at 0.25', () {
    final path = DonutQuartersPainter.sector(_box, 0.25);

    expect(path.contains(const Offset(75, 25)), isTrue);
    expect(path.contains(const Offset(25, 75)), isFalse);
    expect(path.contains(const Offset(25, 25)), isFalse);
  });

  test('the donut sector covers the whole box at 1', () {
    final path = DonutQuartersPainter.sector(_box, 1);

    for (final corner in [
      const Offset(1, 1),
      const Offset(99, 1),
      const Offset(1, 99),
      const Offset(99, 99),
    ]) {
      expect(path.contains(corner), isTrue);
    }
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

  testWidgets('the donut painter paints its photo at 0, 0.25 and 1', (
    tester,
  ) async {
    final photo = await tester.runAsync(() => createTestImage(width: 40));
    addTearDown(photo!.dispose);
    for (final value in [0.0, 0.25, 1.0]) {
      await _paint(
        tester,
        DonutQuartersPainter(
          progress: AlwaysStoppedAnimation(value),
          image: photo,
        ),
      );
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('the tier line and coffee arc paint without errors', (
    tester,
  ) async {
    for (final painter in <CustomPainter>[line(), arc()]) {
      await _paint(tester, painter);
      expect(tester.takeException(), isNull);
    }
  });
}
