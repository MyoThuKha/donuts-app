import 'package:donuts/core/widgets/images/donut_placeholder.dart';
import 'package:donuts/features/auth/presentation/onboarding/views/onboarding_hero_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

void main() {
  testWidgets('onboarding hero draws donut placeholders, not image assets', (
    tester,
  ) async {
    await pumpThemed(
      tester,
      const SizedBox(width: 390, height: 500, child: OnboardingHeroView()),
    );

    expect(
      find.byType(DonutPlaceholder),
      findsNWidgets(onboardingCircles.length),
    );
    expect(find.byType(Image), findsNothing);
  });

  testWidgets('a donut placeholder is decorative to screen readers', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await pumpThemed(
      tester,
      const SizedBox.square(
        dimension: 100,
        child: DonutPlaceholder(glaze: Colors.pink),
      ),
    );

    expect(find.bySemanticsLabel(RegExp('.+')), findsNothing);
    semantics.dispose();
  });
}
