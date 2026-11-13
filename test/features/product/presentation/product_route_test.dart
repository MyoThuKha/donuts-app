import 'package:donuts/core/router/app_routes.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fakes.dart';
import '../../../helpers/pump_app.dart';

void main() {
  testWidgets('opening /product/p_coconut shows the Coconut Donut', (
    tester,
  ) async {
    await pumpRouterApp(
      tester,
      session: testSessionCubit()..signedIn(testUser),
      initialLocation: AppRoutes.productDetail('p_coconut'),
    );

    expect(find.text('Coconut Donut'), findsOneWidget);
    expect(find.text('JD022123'), findsOneWidget);
  });
}
