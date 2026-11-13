import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/features/home/presentation/painters/tier_ring_painter.dart';
import 'package:donuts/features/home/presentation/widgets/tier_ring_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../helpers/pump_app.dart';

const _avatar = 52.0;

Future<void> _pumpRing(
  WidgetTester tester,
  double progress, {
  bool reduceMotion = false,
}) => pumpThemed(
  tester,
  Center(
    child: MediaQuery(
      data: MediaQueryData(disableAnimations: reduceMotion),
      child: TierRingWidget(
        progress: progress,
        child: const SizedBox.square(dimension: _avatar),
      ),
    ),
  ),
);

double _drawn(WidgetTester tester) {
  final paint = tester.widget<CustomPaint>(
    find.descendant(
      of: find.byType(TierRingWidget),
      matching: find.byType(CustomPaint),
    ),
  );
  return (paint.foregroundPainter! as TierRingPainter).progress;
}

TierRingPainter _painter({double progress = 0.5, double stroke = 5}) =>
    TierRingPainter(
      progress: progress,
      start: const Color(0xFFFBE2CB),
      end: const Color(0xFFE5924B),
      stroke: stroke,
      gap: 2,
    );

void main() {
  testWidgets('waits for Home to come in, then sweeps from empty to the '
      'progress', (tester) async {
    await _pumpRing(tester, 0.9);
    expect(_drawn(tester), 0);

    await tester.pump(AppMotion.slow - const Duration(milliseconds: 1));
    expect(_drawn(tester), 0);

    await tester.pump(
      const Duration(milliseconds: 1) + AppMotion.showcase ~/ 2,
    );
    expect(_drawn(tester), inExclusiveRange(0, 0.9));

    await tester.pumpAndSettle();
    expect(_drawn(tester), 0.9);
  });

  testWidgets('moves on from the old progress when the points change', (
    tester,
  ) async {
    await _pumpRing(tester, 0.4);
    await tester.pumpAndSettle();

    await _pumpRing(tester, 0.9);
    expect(_drawn(tester), closeTo(0.4, 1e-9));

    await tester.pump(AppMotion.showcase ~/ 2);
    expect(_drawn(tester), inExclusiveRange(0.4, 0.9));

    await tester.pumpAndSettle();
    expect(_drawn(tester), 0.9);
  });

  testWidgets('under Reduce Motion it shows the progress at once', (
    tester,
  ) async {
    await _pumpRing(tester, 0.9, reduceMotion: true);
    await tester.pump();

    expect(_drawn(tester), 0.9);
  });

  testWidgets('keeps the avatar size, so the header layout does not move', (
    tester,
  ) async {
    await _pumpRing(tester, 0.9);

    expect(
      tester.getSize(find.byType(TierRingWidget)),
      const Size.square(_avatar),
    );
  });

  testWidgets('clamps progress outside 0 to 1', (tester) async {
    await _pumpRing(tester, 1.4, reduceMotion: true);
    await tester.pump();

    expect(_drawn(tester), 1);
  });

  test('the painter repaints only when its values change', () {
    expect(_painter().shouldRepaint(_painter()), isFalse);
    expect(_painter(progress: 0.6).shouldRepaint(_painter()), isTrue);
    expect(_painter(stroke: 4).shouldRepaint(_painter()), isTrue);
  });
}
