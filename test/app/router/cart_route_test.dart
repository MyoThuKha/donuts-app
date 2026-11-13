import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/features/auth/presentation/onboarding/onboarding_screen.dart';
import 'package:donuts/features/cart/presentation/cart_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  testWidgets('a signed-out user opening /cart goes to Onboarding', (
    tester,
  ) async {
    await pumpRouterApp(
      tester,
      session: testSessionCubit(),
      initialLocation: AppRoutes.cart,
    );
    await tester.pumpAndSettle();

    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.byType(CartScreen), findsNothing);
  });

  testWidgets('the Settings cart tag opens the cart', (tester) async {
    await pumpRouterApp(
      tester,
      session: testSessionCubit()..signedIn(testUser),
      initialLocation: AppRoutes.settings,
    );
    await tester.pumpAndSettle();

    await tester.tap(find.bySemanticsLabel(RegExp('^Cart')));
    await tester.pumpAndSettle();

    expect(find.byType(CartScreen), findsOneWidget);
  });

  testWidgets('a double tap on the cart tag opens one cart', (tester) async {
    await pumpRouterApp(
      tester,
      session: testSessionCubit()..signedIn(testUser),
      initialLocation: AppRoutes.settings,
    );
    await tester.pumpAndSettle();

    final tag = find.bySemanticsLabel(RegExp('^Cart'));
    await tester.tap(tag);
    await tester.tap(tag, warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(find.byType(CartScreen, skipOffstage: false), findsOneWidget);
  });
}
