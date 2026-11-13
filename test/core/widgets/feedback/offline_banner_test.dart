import 'package:donuts/core/widgets/feedback/offline_banner.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

void main() {
  testWidgets('the offline banner slides in when visible', (tester) async {
    await pumpThemed(tester, const OfflineBanner(visible: false));
    expect(
      tester.widget<AnimatedSlide>(find.byType(AnimatedSlide)).offset.dy,
      lessThan(0),
    );

    await pumpThemed(tester, const OfflineBanner(visible: true));
    await tester.pumpAndSettle();

    expect(
      tester.widget<AnimatedSlide>(find.byType(AnimatedSlide)).offset,
      Offset.zero,
    );
    expect(find.text('You’re offline. Showing saved data.'), findsOneWidget);
    expect(
      tester.getSemantics(find.text('You’re offline. Showing saved data.')),
      isSemantics(isLiveRegion: true),
    );
  });

  testWidgets('a hidden offline banner says nothing to screen readers', (
    tester,
  ) async {
    await pumpThemed(tester, const OfflineBanner(visible: false));

    expect(
      find.bySemanticsLabel('You’re offline. Showing saved data.'),
      findsNothing,
    );
  });
}
