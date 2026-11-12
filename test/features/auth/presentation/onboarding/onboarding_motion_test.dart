import 'package:donuts/features/auth/presentation/onboarding/onboarding_screen.dart';
import 'package:donuts/features/auth/presentation/onboarding/views/onboarding_hero_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('the donut circles drift in and settle in place', (tester) async {
    await pumpThemed(tester, const OnboardingScreen());
    final firstCircle = find.byType(HeroCircleItem).first;

    final start = tester.getRect(firstCircle);
    await tester.pumpAndSettle();
    final settled = tester.getRect(firstCircle);

    expect(start, isNot(settled));
  });

  testWidgets('the title fades in after the circles start moving', (
    tester,
  ) async {
    await pumpThemed(tester, const OnboardingScreen());
    final title = find.ancestor(
      of: find.text('Round food for every mood'),
      matching: find.byType(FadeTransition),
    );

    expect(
      tester.widget<FadeTransition>(title.first).opacity.value,
      lessThan(1),
    );
    await tester.pumpAndSettle();
    expect(tester.widget<FadeTransition>(title.first).opacity.value, 1);
  });
}
