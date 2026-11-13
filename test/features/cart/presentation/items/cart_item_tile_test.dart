import 'package:donuts/features/cart/domain/cart_rules.dart';
import 'package:donuts/features/cart/domain/vo/cart_item_vo.dart';
import 'package:donuts/features/cart/presentation/items/cart_item_tile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../helpers/cart_fakes.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  Future<({List<String> taps})> pumpTile(
    WidgetTester tester,
    CartItemVO item,
  ) async {
    final taps = <String>[];
    await pumpThemed(
      tester,
      CartItemTile(
        item: item,
        onIncrement: () => taps.add('plus'),
        onDecrement: () => taps.add('minus'),
      ),
    );
    return (taps: taps);
  }

  testWidgets('shows the name, the line total and the quantity', (
    tester,
  ) async {
    await pumpTile(tester, testCoconutLine);

    expect(find.text('Coconut Donut'), findsOneWidget);
    expect(find.text('6,400 MMK'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
  });

  testWidgets('plus and minus call back', (tester) async {
    final (:taps) = await pumpTile(tester, testCoconutLine);

    await tester.tap(find.byIcon(LucideIcons.plus));
    await tester.tap(find.byIcon(LucideIcons.minus));

    expect(taps, ['plus', 'minus']);
  });

  testWidgets('at 1 the minus is a Remove button', (tester) async {
    final (:taps) = await pumpTile(tester, testBerryLine);

    await tester.tap(find.byIcon(LucideIcons.trash2));

    expect(taps, ['minus']);
  });

  testWidgets('plus is disabled at 99', (tester) async {
    final (:taps) = await pumpTile(
      tester,
      testCoconutLine.copyWith(quantity: CartRules.maxQuantity),
    );

    await tester.tap(find.byIcon(LucideIcons.plus));

    expect(taps, isEmpty);
  });
}
