import 'package:donuts/core/widgets/buttons/pill_button.dart';
import 'package:donuts/core/widgets/feedback/section_empty_state.dart';
import 'package:donuts/core/widgets/feedback/section_error_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  testWidgets('the error card shows its message and a Try again pill that '
      'retries', (tester) async {
    var retries = 0;
    await pumpThemed(
      tester,
      SectionErrorState(message: 'Could not load.', onRetry: () => retries++),
    );

    expect(find.text('Could not load.'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Try again'));
    await tester.pump();

    expect(retries, 1);
  });

  testWidgets('the Try again pill meets the 44 pt tap target', (tester) async {
    await pumpThemed(
      tester,
      SectionErrorState(message: 'Could not load.', onRetry: () {}),
    );

    expect(
      tester.getSize(find.byType(AppPillButton)).height,
      greaterThanOrEqualTo(44),
    );
  });

  testWidgets('the empty card shows its message and no button', (tester) async {
    await pumpThemed(tester, const SectionEmptyState(message: 'Nothing yet.'));

    expect(find.text('Nothing yet.'), findsOneWidget);
    expect(find.byType(AppPillButton), findsNothing);
  });
}
