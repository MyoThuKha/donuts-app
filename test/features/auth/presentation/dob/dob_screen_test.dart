import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/features/auth/domain/params/registration_params.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/auth_flow.dart';
import '../../../../helpers/fakes.dart';
import '../../../../helpers/pump_app.dart';

final Finder _continue = find.byType(AppPrimaryButton);

bool _enabled(WidgetTester tester) =>
    tester.widget<AppPrimaryButton>(_continue).onPressed != null;

Future<void> _tapContinue(WidgetTester tester) async {
  await tester.tap(_continue);
  await tester.pumpAndSettle();
}

/// Fills the date fields: picks [month] from the sheet, types day and year.
Future<void> _enterDate(
  WidgetTester tester, {
  required String month,
  required String day,
  required String year,
}) async {
  await tester.tap(find.text('Month'));
  await tester.pumpAndSettle();
  await tester.tap(find.text(month).last);
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField).at(0), day);
  await tester.enterText(find.byType(TextField).at(1), year);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(registerAuthFallbacks);

  late AuthFlowMocks mocks;

  setUp(() async {
    mocks = AuthFlowMocks();
    await mocks.install();
  });

  Future<void> pumpDob(WidgetTester tester) async {
    await pumpRouterApp(
      tester,
      session: testSessionCubit(),
      initialLocation: AppRoutes.registerName,
    );
    await tester.enterText(find.byType(TextField).first, 'Ye Min');
    await tester.pump();
    await _tapContinue(tester);
  }

  testWidgets('31 April is rejected and Continue stays disabled', (
    tester,
  ) async {
    await pumpDob(tester);

    await _enterDate(tester, month: 'April', day: '31', year: '2000');

    expect(find.text("That date doesn't exist"), findsOneWidget);
    expect(_enabled(tester), isFalse);
  });

  testWidgets('someone under 13 is told the minimum age', (tester) async {
    await pumpDob(tester);

    await _enterDate(tester, month: 'May', day: '1', year: '2014');

    expect(find.text('You need to be at least 13 to join'), findsOneWidget);
    expect(_enabled(tester), isFalse);
  });

  testWidgets('the date step is the last of four', (tester) async {
    await pumpDob(tester);

    expect(find.bySemanticsLabel('Step 4 of 4'), findsOneWidget);
  });

  testWidgets(
    'the whole sign-up registers once and lands on Welcome, then Home',
    (tester) async {
      final user = UserVO(
        id: 1,
        phone: '+959254135592',
        firstName: 'Ye Min',
        lastName: 'Phyoe Win',
        dateOfBirth: DateTime(1980, 5),
      );
      when(() => mocks.verifyOtp(any()))
          .thenAnswer((_) async => const Success<UserVO?>(null));
      when(() => mocks.register(any())).thenAnswer((_) async => Success(user));
      final session = testSessionCubit();
      await pumpRouterApp(
        tester,
        session: session,
        initialLocation: AppRoutes.registerPhone,
      );

      await tester.enterText(find.byType(TextField), '09254135592');
      await tester.pump();
      await _tapContinue(tester);
      await tester.enterText(find.byType(TextField), '123456');
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).at(0), ' Ye Min ');
      await tester.enterText(find.byType(TextField).at(1), 'Phyoe Win');
      await tester.pump();
      await _tapContinue(tester);
      await _enterDate(tester, month: 'May', day: '1', year: '1980');
      await tester.tap(_continue);
      await tester.tap(_continue, warnIfMissed: false);
      await tester.pumpAndSettle();

      final params =
          verify(() => mocks.register(captureAny())).captured.single
              as RegistrationParams;
      expect(params.phone, '+959254135592');
      expect(params.firstName, 'Ye Min');
      expect(params.lastName, 'Phyoe Win');
      expect(params.dateOfBirth, DateTime(1980, 5));
      expect(session.state, SessionSignedIn(user, justRegistered: true));
      expect(find.text("Welcome to the world of J'donuts"), findsOneWidget);

      await tester.tap(find.byType(AppPrimaryButton));
      await tester.pumpAndSettle();
      expect(find.text('Home is coming soon'), findsOneWidget);
    },
  );
}
