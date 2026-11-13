import 'package:donuts/core/widgets/inputs/quantity_stepper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../helpers/pump_app.dart';

void main() {
  testWidgets('screen readers can press plus and minus', (tester) async {
    final handle = tester.ensureSemantics();
    var increments = 0;
    var decrements = 0;
    await pumpThemed(
      tester,
      QuantityStepper(
        quantity: 2,
        onIncrement: () => increments++,
        onDecrement: () => decrements++,
      ),
    );

    tester.semantics.tap(find.semantics.byLabel('Increase quantity'));
    tester.semantics.tap(find.semantics.byLabel('Decrease quantity'));

    expect(increments, 1);
    expect(decrements, 1);
    handle.dispose();
  });

  testWidgets('with minusRemoves, the minus is a Remove button', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    var decrements = 0;
    await pumpThemed(
      tester,
      QuantityStepper(
        quantity: 1,
        minusRemoves: true,
        onIncrement: () {},
        onDecrement: () => decrements++,
      ),
    );

    expect(find.byIcon(LucideIcons.trash2), findsOneWidget);
    expect(find.byIcon(LucideIcons.minus), findsNothing);
    tester.semantics.tap(find.semantics.byLabel('Remove'));
    expect(decrements, 1);
    handle.dispose();
  });
}
