import 'dart:async';

import 'package:donuts/core/motion/app_motion.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

void main() {
  testWidgets('a button without onPressed ignores taps', (tester) async {
    await pumpThemed(tester, const AppPrimaryButton(label: 'Continue'));

    await tester.tap(find.byType(AppPrimaryButton));

    expect(tester.takeException(), isNull);
  });

  testWidgets('a loading button shows a spinner and ignores taps', (
    tester,
  ) async {
    var taps = 0;
    await pumpThemed(
      tester,
      AppPrimaryButton(
        label: 'Continue',
        loading: true,
        onPressed: () => taps++,
      ),
    );
    await tester.pump(AppMotion.medium);

    await tester.tap(find.byType(AppPrimaryButton), warnIfMissed: false);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('CONTINUE'), findsNothing);
    expect(taps, 0);
  });

  testWidgets('holding the button grows it gently', (tester) async {
    await pumpThemed(
      tester,
      AppPrimaryButton(label: 'Continue', onPressed: () {}),
    );

    final gesture = await tester.startGesture(
      tester.getCenter(find.byType(AppPrimaryButton)),
    );
    await tester.pumpAndSettle();

    final scale = tester.widget<ScaleTransition>(
      find.descendant(
        of: find.byType(AppPrimaryButton),
        matching: find.byType(ScaleTransition),
      ),
    );
    expect(scale.scale.value, closeTo(AppMotion.pressGrowWide, 1e-6));
    await gesture.up();
  });

  testWidgets('a tap calls onPressed once', (tester) async {
    var taps = 0;
    await pumpThemed(
      tester,
      AppPrimaryButton(label: 'Continue', onPressed: () => taps++),
    );

    await tester.tap(find.byType(AppPrimaryButton));

    expect(taps, 1);
  });

  testWidgets('taps are ignored until the future the last tap returned '
      'completes, then work again', (tester) async {
    var taps = 0;
    var pending = Completer<void>();
    await pumpThemed(
      tester,
      AppPrimaryButton(
        label: 'Continue',
        onPressed: () {
          taps++;
          return pending.future;
        },
      ),
    );

    await tester.tap(find.byType(AppPrimaryButton));
    await tester.tap(find.byType(AppPrimaryButton));
    expect(taps, 1);

    pending.complete();
    await tester.pump();
    pending = Completer<void>();
    await tester.tap(find.byType(AppPrimaryButton));
    expect(taps, 2);
  });

  testWidgets('a synchronous onPressed runs on every tap', (tester) async {
    var taps = 0;
    await pumpThemed(
      tester,
      AppPrimaryButton(label: 'Close', onPressed: () => taps++),
    );

    await tester.tap(find.byType(AppPrimaryButton));
    await tester.tap(find.byType(AppPrimaryButton));

    expect(taps, 2);
  });
}
