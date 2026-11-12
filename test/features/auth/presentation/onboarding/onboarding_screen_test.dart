import 'package:donuts/features/auth/presentation/onboarding/onboarding_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the title, the call to action and Log In', (tester) async {
    await pumpThemed(tester, const OnboardingScreen());
    await tester.pumpAndSettle();

    expect(find.text('Round food for every mood'), findsOneWidget);
    expect(find.text("LET'S GET STARTED"), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
  });

  testWidgets('Google opens a placeholder sheet naming Google', (tester) async {
    await pumpThemed(tester, const OnboardingScreen());
    await tester.pumpAndSettle();

    await tester.tap(find.bySemanticsLabel('Continue with Google'));
    await tester.pumpAndSettle();

    expect(
      find.text("Google sign-in isn't available in this demo"),
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
}
