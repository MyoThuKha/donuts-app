import 'package:donuts/core/widgets/badges/discount_badge.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  testWidgets('DiscountBadge shows 50% off', (tester) async {
    await pumpThemed(tester, const DiscountBadge(percent: 50));

    expect(find.text('50% off'), findsOneWidget);
  });
}
