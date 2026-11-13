import 'dart:async';

import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/features/auth/presentation/otp/otp_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/auth_flow.dart';
import '../../../../helpers/fakes.dart';
import '../../../../helpers/pump_app.dart';

final Finder _continue = find.byType(AppPrimaryButton);
final Finder _field = find.byType(TextField);

bool _enabled(WidgetTester tester) =>
    tester.widget<AppPrimaryButton>(_continue).onPressed != null;

void main() {
  setUpAll(registerAuthFallbacks);

  late AuthFlowMocks mocks;

  setUp(() async {
    mocks = AuthFlowMocks();
    await mocks.install();
  });

  Future<void> pumpPhone(WidgetTester tester, String route) => pumpRouterApp(
    tester,
    session: testSessionCubit(),
    initialLocation: route,
  );

  testWidgets('Continue stays disabled until the number is valid', (
    tester,
  ) async {
    await pumpPhone(tester, AppRoutes.logInPhone);

    await tester.enterText(_field, '0912345');
    await tester.pump();
    expect(_enabled(tester), isFalse);

    await tester.enterText(_field, '09254135592');
    await tester.pump();
    expect(_enabled(tester), isTrue);
  });

  testWidgets('an invalid number shows its message only after blur', (
    tester,
  ) async {
    await pumpPhone(tester, AppRoutes.logInPhone);
    const message = 'Enter a Myanmar mobile number, like 09 254 135 592';

    await tester.enterText(_field, '0912345');
    await tester.pumpAndSettle();
    expect(find.text(message), findsNothing);

    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    expect(find.text(message), findsOneWidget);
  });

  testWidgets('logging in with an unregistered number offers to register', (
    tester,
  ) async {
    when(() => mocks.requestOtp(any()))
        .thenAnswer((_) async => const Failure(NotRegisteredFailure()));
    await pumpPhone(tester, AppRoutes.logInPhone);

    await tester.enterText(_field, '09254135592');
    await tester.pump();
    await tester.tap(_continue);
    await tester.pumpAndSettle();

    expect(find.text('This number isn’t registered yet.'), findsOneWidget);
    await tester.tap(find.text('Register instead'));
    await tester.pumpAndSettle();
    expect(find.text('Enter your phone number'), findsOneWidget);
    expect(find.bySemanticsLabel('Step 1 of 4'), findsOneWidget);
  });

  testWidgets('a double tap on Continue sends one OTP request', (tester) async {
    final pending = Completer<Result<void>>();
    when(() => mocks.requestOtp(any())).thenAnswer((_) => pending.future);
    await pumpPhone(tester, AppRoutes.logInPhone);

    await tester.enterText(_field, '09254135592');
    await tester.pump();
    await tester.tap(_continue);
    await tester.pump();
    await tester.tap(_continue, warnIfMissed: false);
    await tester.pump();

    verify(() => mocks.requestOtp(any())).called(1);
    expect(tester.widget<AppPrimaryButton>(_continue).loading, isTrue);
    pending.complete(const Success(null));
    await tester.pumpAndSettle();
    await unmountApp(tester);
  });

  testWidgets('registering a known number offers to log in instead', (
    tester,
  ) async {
    when(() => mocks.requestOtp(any()))
        .thenAnswer((_) async => const Failure(AlreadyRegisteredFailure()));
    await pumpPhone(tester, AppRoutes.registerPhone);

    await tester.enterText(_field, '09254135592');
    await tester.pump();
    await tester.tap(_continue);
    await tester.pumpAndSettle();

    expect(find.text('This number is already registered.'), findsOneWidget);
    expect(find.text('Log in instead'), findsOneWidget);
  });

  testWidgets('a second tap after the code is sent opens one OTP step and '
      'sends no second code', (tester) async {
    await pumpPhone(tester, AppRoutes.logInPhone);
    await tester.enterText(_field, '09254135592');
    await tester.pump();

    await tester.tap(_continue);
    await tester.tap(_continue, warnIfMissed: false);
    await tester.pumpAndSettle();

    verify(() => mocks.requestOtp(any())).called(1);
    expect(find.byType(OtpScreen, skipOffstage: false), findsOneWidget);
    await unmountApp(tester);
  });
}
