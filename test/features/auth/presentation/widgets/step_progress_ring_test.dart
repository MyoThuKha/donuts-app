import 'package:donuts/features/auth/presentation/widgets/step_progress_painter.dart';
import 'package:donuts/features/auth/presentation/widgets/step_progress_ring_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../helpers/pump_app.dart';

StepProgressPainter _painter(WidgetTester tester) =>
    tester
            .widget<CustomPaint>(
              find.descendant(
                of: find.byType(StepProgressRing),
                matching: find.byType(CustomPaint),
              ),
            )
            .painter!
        as StepProgressPainter;

void main() {
  testWidgets('step 2 of 4 sweeps from a quarter to half', (tester) async {
    await pumpThemed(tester, const StepProgressRing(step: 2, of: 4));

    await tester.pump(const Duration(milliseconds: 150));
    final midway = _painter(tester).progress;
    await tester.pumpAndSettle();

    expect(midway, inExclusiveRange(0.25, 0.5));
    expect(_painter(tester).progress, 0.5);
    expect(_painter(tester).checkProgress, 0);
  });

  testWidgets('the last step closes the ring and draws the check', (
    tester,
  ) async {
    await pumpThemed(tester, const StepProgressRing(step: 4, of: 4));

    await tester.pumpAndSettle();

    expect(_painter(tester).progress, 1);
    expect(_painter(tester).checkProgress, 1);
  });

  testWidgets('Reduce Motion shows the final state on the first frame', (
    tester,
  ) async {
    await pumpThemed(
      tester,
      const MediaQuery(
        data: MediaQueryData(disableAnimations: true),
        child: StepProgressRing(step: 4, of: 4),
      ),
    );
    await tester.pump();

    expect(_painter(tester).progress, 1);
    expect(_painter(tester).checkProgress, 1);
  });
}
