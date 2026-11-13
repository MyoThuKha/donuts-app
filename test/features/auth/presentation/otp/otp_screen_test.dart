import 'dart:async';

import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/features/auth/domain/params/otp_params.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/auth_flow.dart';
import '../../../../helpers/fakes.dart';
import '../../../../helpers/pump_app.dart';

final Finder _field = find.byType(TextField);

/// The countdown in "resend in 4:58 min", read from the screen.
Duration _countdown(WidgetTester tester) {
  final line = tester
      .widgetList<RichText>(find.byType(RichText))
      .map((w) => w.text.toPlainText())
      .firstWhere((t) => t.startsWith('resend in'));
  final match = RegExp(r'(\d+):(\d\d)').firstMatch(line)!;
  return Duration(minutes: int.parse(match[1]!), seconds: int.parse(match[2]!));
}

/// Opens the OTP step the way a user does: phone, then Continue.
Future<void> _openOtp(WidgetTester tester) async {
  await pumpRouterApp(
    tester,
    session: testSessionCubit(),
    initialLocation: AppRoutes.logInPhone,
  );
  await tester.enterText(_field, '09254135592');
  await tester.pump();
  await tester.tap(find.byType(AppPrimaryButton));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(registerAuthFallbacks);

  late AuthFlowMocks mocks;

  setUp(() async {
    mocks = AuthFlowMocks();
    await mocks.install();
    when(() => mocks.verifyOtp(any()))
        .thenAnswer((_) async => const Failure(WrongOtpFailure()));
  });

  tearDown(() => FocusManager.instance.primaryFocus?.unfocus());

  testWidgets('a wrong code shows the message and clears the boxes', (
    tester,
  ) async {
    await _openOtp(tester);

    await tester.enterText(_field, '000000');
    await tester.pumpAndSettle();

    expect(find.text('That code isn’t right. Try again.'), findsOneWidget);
    expect(tester.widget<TextField>(_field).controller!.text, isEmpty);
    await unmountApp(tester);
  });

  testWidgets('three wrong codes lock entry until Resend', (tester) async {
    await _openOtp(tester);

    for (var i = 0; i < 3; i++) {
      await tester.enterText(_field, '000000');
      await tester.pumpAndSettle();
    }

    expect(
      find.text('Too many wrong codes. Tap Resend to get a new one.'),
      findsOneWidget,
    );
    expect(tester.widget<TextField>(_field).enabled, isFalse);
    expect(find.text('Resend'), findsOneWidget);
    await unmountApp(tester);
  });

  testWidgets('pasting six digits fills every box and verifies', (
    tester,
  ) async {
    await _openOtp(tester);

    await tester.enterText(_field, '123456');
    await tester.pumpAndSettle();

    final sent = verify(() => mocks.verifyOtp(captureAny())).captured.single;
    expect((sent as OtpVerificationParams).code, '123456');
    await unmountApp(tester);
  });

  testWidgets('while the code is checked, a spinner shows and entry pauses', (
    tester,
  ) async {
    final pending = Completer<Result<UserVO?>>();
    when(() => mocks.verifyOtp(any())).thenAnswer((_) => pending.future);
    await _openOtp(tester);

    await tester.enterText(_field, '123456');
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(tester.widget<TextField>(_field).enabled, isFalse);
    pending.complete(const Failure(WrongOtpFailure()));
    await tester.pumpAndSettle();
    await unmountApp(tester);
  });

  testWidgets('backspace removes the last digit', (tester) async {
    await _openOtp(tester);

    await tester.enterText(_field, '123');
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
    await tester.pump();

    expect(tester.widget<TextField>(_field).controller!.text, '12');
    await unmountApp(tester);
  });

  testWidgets('the resend countdown starts near 5:00 and ticks down', (
    tester,
  ) async {
    await _openOtp(tester);
    final start = _countdown(tester);

    await tester.pump(const Duration(seconds: 1));

    expect(
      start,
      greaterThanOrEqualTo(const Duration(minutes: 4, seconds: 58)),
    );
    expect(_countdown(tester), start - const Duration(seconds: 1));
    await unmountApp(tester);
  });

  testWidgets('back to Phone keeps the number, and forward restarts at 5:00', (
    tester,
  ) async {
    await _openOtp(tester);
    await tester.pump(const Duration(seconds: 30));
    final beforeBack = _countdown(tester);

    await tester.tap(find.bySemanticsLabel('Back'));
    await tester.pumpAndSettle();
    expect(find.text('09254135592'), findsOneWidget);

    await tester.tap(find.byType(AppPrimaryButton));
    await tester.pumpAndSettle();
    expect(_countdown(tester), greaterThan(beforeBack));
    await unmountApp(tester);
  });
}
