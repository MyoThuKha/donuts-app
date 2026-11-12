import 'package:donuts/core/router/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

const _onboardingTitle = 'Round food for every mood';

void main() {
  testWidgets('signed out, a protected route opens Onboarding', (tester) async {
    await pumpRouterApp(tester, session: testSessionCubit());

    expect(find.text(_onboardingTitle), findsOneWidget);
  });

  testWidgets('signed in, Onboarding redirects to Home', (tester) async {
    final session = testSessionCubit()..signedIn(testUser);

    await pumpRouterApp(
      tester,
      session: session,
      initialLocation: AppRoutes.onboarding,
    );

    expect(find.text('Home is coming soon'), findsOneWidget);
  });

  testWidgets('just registered, any route opens Welcome first', (tester) async {
    final session = testSessionCubit()
      ..signedIn(testUser, justRegistered: true);

    await pumpRouterApp(tester, session: session);

    expect(find.byKey(const ValueKey(AppRoutes.welcome)), findsOneWidget);
  });

  testWidgets('signing out while on Home moves to Onboarding', (tester) async {
    final session = testSessionCubit()..signedIn(testUser);
    await pumpRouterApp(tester, session: session);

    await session.logOut();
    await tester.pumpAndSettle();

    expect(find.text(_onboardingTitle), findsOneWidget);
  });
}
