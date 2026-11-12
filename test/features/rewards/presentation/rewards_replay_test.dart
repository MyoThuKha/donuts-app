import 'package:donuts/app/shell/widgets/nav_icons.dart';
import 'package:donuts/features/rewards/presentation/painters/points_ring_painter.dart';
import 'package:donuts/features/rewards/presentation/painters/quarter_clipper.dart';
import 'package:donuts/features/rewards/presentation/rewards_motion.dart';
import 'package:donuts/features/rewards/presentation/widgets/earn_button_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/fakes.dart';
import '../../../helpers/pump_app.dart';

double _ringProgress(WidgetTester tester) => tester
    .widgetList<CustomPaint>(find.byType(CustomPaint))
    .map((p) => p.painter)
    .whereType<PointsRingPainter>()
    .single
    .progress
    .value;

/// The pulse scale of the one active Earn button: its outer ScaleTransition
/// (the press scale sits inside it).
double _earnPulse(WidgetTester tester) {
  final earn = find.byWidgetPredicate((w) => w is EarnButton && w.active);
  return tester
      .widget<ScaleTransition>(
        find.descendant(of: earn, matching: find.byType(ScaleTransition)).first,
      )
      .scale
      .value;
}

void main() {
  testWidgets('coming back to the Rewards tab replays the ring sweep', (
    tester,
  ) async {
    await pumpRouterApp(
      tester,
      session: testSessionCubit()..signedIn(testUser),
    );
    await tester.tap(find.byKey(const ValueKey(NavIcons.reward)));
    await tester.pumpAndSettle();
    expect(_ringProgress(tester), closeTo(0.75, 0.001));

    await tester.tap(find.byKey(const ValueKey(NavIcons.home)));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey(NavIcons.reward)));
    await tester.pump();

    expect(_ringProgress(tester), closeTo(0, 0.01));
    await tester.pumpAndSettle();
    expect(_ringProgress(tester), closeTo(0.75, 0.001));
  });

  testWidgets('switching tabs inside Rewards does not replay the entrance', (
    tester,
  ) async {
    await pumpRouterApp(
      tester,
      session: testSessionCubit()..signedIn(testUser),
    );
    await tester.tap(find.byKey(const ValueKey(NavIcons.reward)));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Gift'));
    await tester.pump();

    expect(_ringProgress(tester), closeTo(0.75, 0.001));
  });

  testWidgets('coming back to the Rewards tab pulses the complete Earn again', (
    tester,
  ) async {
    await pumpRouterApp(
      tester,
      session: testSessionCubit()..signedIn(testUser),
    );
    await tester.tap(find.byKey(const ValueKey(NavIcons.reward)));
    await tester.pumpAndSettle();
    expect(_earnPulse(tester), 1);

    await tester.tap(find.byKey(const ValueKey(NavIcons.home)));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey(NavIcons.reward)));
    await tester.pump();
    await tester.pump(RewardsMotion.earnPulsePeriod * 0.75);

    expect(_earnPulse(tester), greaterThan(1));
  });

  testWidgets(
    'coming back to the Rewards tab replays the cards and their art',
    (tester) async {
      double cocoDonut() => tester
          .widgetList<ClipPath>(find.byType(ClipPath))
          .map((c) => c.clipper)
          .whereType<QuarterClipper>()
          .first
          .fraction;
      await pumpRouterApp(
        tester,
        session: testSessionCubit()..signedIn(testUser),
      );
      await tester.tap(find.byKey(const ValueKey(NavIcons.reward)));
      await tester.pumpAndSettle();
      expect(cocoDonut(), 1);

      await tester.tap(find.byKey(const ValueKey(NavIcons.home)));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey(NavIcons.reward)));
      await tester.pump();

      expect(cocoDonut(), closeTo(0, 0.01));
      await tester.pumpAndSettle();
      expect(cocoDonut(), 1);
    },
  );

  testWidgets('a pressed Earn stays still when the user comes back', (
    tester,
  ) async {
    await pumpRouterApp(
      tester,
      session: testSessionCubit()..signedIn(testUser),
    );
    await tester.tap(find.byKey(const ValueKey(NavIcons.reward)));
    await tester.pumpAndSettle();
    final earn = find.byWidgetPredicate((w) => w is EarnButton && w.active);
    // Centred, not at the bottom edge, where the bottom nav covers it.
    await Scrollable.ensureVisible(tester.element(earn), alignment: 0.5);
    await tester.pumpAndSettle();
    await tester.tap(earn);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey(NavIcons.home)));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey(NavIcons.reward)));
    await tester.pump();
    await tester.pump(RewardsMotion.earnPulsePeriod * 0.75);

    expect(_earnPulse(tester), 1);
  });
}
