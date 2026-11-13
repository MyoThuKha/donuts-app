import 'package:donuts/features/rewards/presentation/widgets/earn_button_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../helpers/pump_app.dart';

/// The outer ScaleTransition is the pulse; AnimatedScale adds another.
bool _pulsing(WidgetTester tester) => tester
    .widget<ScaleTransition>(
      find
          .descendant(
            of: find.byType(EarnButton),
            matching: find.byType(ScaleTransition),
          )
          .first,
    )
    .scale
    .isAnimating;

void main() {
  testWidgets('tapping a grey Earn does not count as a press', (tester) async {
    var presses = 0;
    await pumpThemed(
      tester,
      EarnButton(active: false, label: 'Earn', onPressed: () => presses++),
    );

    await tester.tap(find.byType(EarnButton));
    await tester.pump();

    expect(presses, 0);
  });

  testWidgets(
    'a grey Earn tapped before its challenge completes still pulses after',
    (tester) async {
      await pumpThemed(tester, const EarnButton(active: false, label: 'Earn'));
      await tester.tap(find.byType(EarnButton));
      await tester.pump();

      await pumpThemed(
        tester,
        const EarnButton(active: true, pulse: true, label: 'Earn'),
      );
      await tester.pump();

      expect(_pulsing(tester), isTrue);
    },
  );

  testWidgets('screen readers get no tap on a grey Earn', (tester) async {
    final handle = tester.ensureSemantics();
    await pumpThemed(tester, const EarnButton(active: false, label: 'Earn'));

    expect(
      () => tester.semantics.tap(find.semantics.byLabel('Earn')),
      throwsStateError,
    );
    handle.dispose();
  });
}
