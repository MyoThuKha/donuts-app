import 'dart:async';

import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/features/auth/domain/params/registration_params.dart';
import 'package:donuts/features/auth/domain/validators/date_of_birth_validator.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_state.dart';
import 'package:donuts/features/home/presentation/home_screen.dart';
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

CupertinoDatePicker _wheel(WidgetTester tester) =>
    tester.widget<CupertinoDatePicker>(find.byType(CupertinoDatePicker));

/// Opens the wheel from the Month field, turns it to [date] and taps Select.
Future<void> _pickDate(WidgetTester tester, DateTime date) async {
  await tester.tap(find.text('Month'));
  await tester.pumpAndSettle();
  _wheel(tester).onDateTimeChanged(date);
  await tester.tap(find.text('SELECT'));
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

  testWidgets('Continue stays disabled until a date is picked', (tester) async {
    await pumpDob(tester);
    expect(_enabled(tester), isFalse);

    await tester.tap(find.text('Day'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();

    expect(find.text('Day'), findsOneWidget);
    expect(_enabled(tester), isFalse);
  });

  testWidgets('a picked date fills all three fields', (tester) async {
    await pumpDob(tester);

    await _pickDate(tester, DateTime(1980, 5));

    expect(find.text('May'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    expect(find.text('1980'), findsOneWidget);
    expect(_enabled(tester), isTrue);
  });

  testWidgets('the wheel stops at the youngest allowed age', (tester) async {
    await pumpDob(tester);

    await tester.tap(find.text('Year'));
    await tester.pumpAndSettle();

    // AuthFlowMocks fixes today at 12 November 2026.
    final range = dateOfBirthRange(DateTime(2026, 11, 12));
    expect(_wheel(tester).maximumDate, range.latest);
    expect(_wheel(tester).minimumDate, range.earliest);
  });

  testWidgets('reopening the wheel starts on the picked date', (tester) async {
    await pumpDob(tester);
    await _pickDate(tester, DateTime(1980, 5));

    await tester.tap(find.text('1980'));
    await tester.pumpAndSettle();

    expect(_wheel(tester).initialDateTime, DateTime(1980, 5));
  });

  testWidgets('Back does nothing while the account is being created', (
    tester,
  ) async {
    final pending = Completer<Result<UserVO>>();
    when(() => mocks.register(any())).thenAnswer((_) => pending.future);
    await pumpRouterApp(
      tester,
      session: testSessionCubit(),
      initialLocation: AppRoutes.registerPhone,
    );
    await tester.enterText(find.byType(TextField), '09254135592');
    await tester.pump();
    await _tapContinue(tester);
    when(() => mocks.verifyOtp(any()))
        .thenAnswer((_) async => const Success<UserVO?>(null));
    await tester.enterText(find.byType(TextField), '123456');
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'Ye Min');
    await tester.pump();
    await _tapContinue(tester);
    await _pickDate(tester, DateTime(1980, 5));

    await tester.tap(_continue);
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('Back'), warnIfMissed: false);
    // The spinner keeps animating while the request is pending.
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('What’s your date of birth?'), findsOneWidget);
    pending.complete(
      Success(
        UserVO(
          id: 1,
          phone: '+959254135592',
          firstName: 'Ye Min',
          dateOfBirth: DateTime(1980, 5),
        ),
      ),
    );
    await tester.pumpAndSettle();
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
      await _pickDate(tester, DateTime(1980, 5));
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
      expect(find.text('Welcome to the world of J’donuts'), findsOneWidget);

      await tester.tap(find.byType(AppPrimaryButton));
      await tester.pumpAndSettle();
      expect(find.byType(HomeScreen), findsOneWidget);
    },
  );
}
