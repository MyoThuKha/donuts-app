import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../helpers/auth_flow.dart';
import '../../../../helpers/fakes.dart';
import '../../../../helpers/pump_app.dart';

final Finder _first = find.byType(TextField).at(0);
final Finder _last = find.byType(TextField).at(1);

bool _enabled(WidgetTester tester) =>
    tester.widget<AppPrimaryButton>(find.byType(AppPrimaryButton)).onPressed !=
    null;

void main() {
  setUpAll(registerAuthFallbacks);

  setUp(() => AuthFlowMocks().install());

  Future<void> pumpName(WidgetTester tester) => pumpRouterApp(
    tester,
    session: testSessionCubit(),
    initialLocation: AppRoutes.registerName,
  );

  testWidgets('Continue stays disabled without a first name', (tester) async {
    await pumpName(tester);

    expect(_enabled(tester), isFalse);
  });

  testWidgets('a digit in the first name shows a message after blur', (
    tester,
  ) async {
    await pumpName(tester);

    await tester.enterText(_first, 'Ye2');
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();

    expect(find.text('Use letters and spaces only'), findsOneWidget);
    expect(_enabled(tester), isFalse);
  });

  testWidgets('a Myanmar first name with no last name can continue', (
    tester,
  ) async {
    await pumpName(tester);

    await tester.enterText(_first, 'ရဲမင်း');
    await tester.pump();

    expect(_enabled(tester), isTrue);
  });

  testWidgets('back from Date of birth shows the names typed before', (
    tester,
  ) async {
    await pumpName(tester);
    await tester.enterText(_first, 'Ye Min');
    await tester.enterText(_last, 'Phyoe Win');
    await tester.pump();

    await tester.tap(find.byType(AppPrimaryButton));
    await tester.pumpAndSettle();
    expect(find.text('What’s your date of birth?'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Back'));
    await tester.pumpAndSettle();

    expect(find.text('Ye Min'), findsOneWidget);
    expect(find.text('Phyoe Win'), findsOneWidget);
  });
}
