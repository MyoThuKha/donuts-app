import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/features/auth/presentation/onboarding/onboarding_screen.dart';
import 'package:donuts/features/auth/presentation/phone/phone_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/auth_flow.dart';
import '../../../../helpers/fakes.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the title, the call to action and Log In', (tester) async {
    await pumpThemed(tester, const OnboardingScreen());
    await tester.pumpAndSettle();

    expect(find.text('Round food for every mood'), findsOneWidget);
    expect(find.text('LET’S GET STARTED'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
  });

  testWidgets('Google opens a placeholder sheet naming Google', (tester) async {
    await pumpThemed(tester, const OnboardingScreen());
    await tester.pumpAndSettle();

    await tester.tap(find.bySemanticsLabel('Continue with Google'));
    await tester.pumpAndSettle();

    expect(
      find.text('Google sign-in isn’t available in this demo'),
      findsOneWidget,
    );
  });

  testWidgets('Terms of Use opens a placeholder sheet', (tester) async {
    await pumpThemed(tester, const OnboardingScreen());
    await tester.pumpAndSettle();

    await tester.tapOnText(find.textRange.ofSubstring('Terms of Use'));
    await tester.pumpAndSettle();

    expect(find.text('Coming soon'), findsOneWidget);
  });

  group('a double tap opens its step once', () {
    setUpAll(registerAuthFallbacks);
    setUp(() => AuthFlowMocks().install());

    Future<void> doubleTap(WidgetTester tester, Finder target) async {
      await pumpRouterApp(
        tester,
        session: testSessionCubit(),
        initialLocation: AppRoutes.onboarding,
      );
      await tester.tap(target);
      await tester.tap(target, warnIfMissed: false);
      await tester.pumpAndSettle();
    }

    testWidgets("on Let's get started", (tester) async {
      await doubleTap(tester, find.byType(AppPrimaryButton));

      expect(find.byType(PhoneScreen, skipOffstage: false), findsOneWidget);
    });

    testWidgets('on Log In', (tester) async {
      await doubleTap(tester, find.text('Log In'));

      expect(find.byType(PhoneScreen, skipOffstage: false), findsOneWidget);
    });
  });
}
