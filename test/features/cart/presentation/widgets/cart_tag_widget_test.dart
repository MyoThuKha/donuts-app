import 'package:donuts/core/widgets/badges/app_tag.dart';
import 'package:donuts/features/cart/presentation/widgets/cart_tag_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the count', (tester) async {
    await pumpThemed(tester, CartTagWidget(count: 3, onTap: () {}));

    expect(find.byIcon(LucideIcons.shoppingCart), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('hides the count at 0', (tester) async {
    await pumpThemed(tester, CartTagWidget(count: 0, onTap: () {}));

    expect(find.byType(AppTag), findsNothing);
  });

  testWidgets('screen readers hear the item count and can open it', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    var opened = 0;
    await pumpThemed(tester, CartTagWidget(count: 2, onTap: () => opened++));

    tester.semantics.tap(find.semantics.byLabel('Cart, 2 items'));

    expect(opened, 1);
    handle.dispose();
  });
}
