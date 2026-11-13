import 'dart:async';

import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/domain/auth_rules.dart';
import 'package:donuts/features/auth/domain/types/auth_mode.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:donuts/features/auth/presentation/otp/blocs/otp_cubit.dart';
import 'package:donuts/features/auth/presentation/otp/blocs/otp_state.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/fakes.dart';

const _phone = '+959254135592';

void main() {
  setUpAll(registerAuthFallbacks);

  late MockVerifyOtpUseCase verifyOtp;
  late MockRequestOtpUseCase requestOtp;

  setUp(() {
    verifyOtp = MockVerifyOtpUseCase();
    requestOtp = MockRequestOtpUseCase();
    when(() => verifyOtp(any()))
        .thenAnswer((_) async => const Failure(WrongOtpFailure()));
    when(() => requestOtp(any())).thenAnswer((_) async => const Success(null));
  });

  OtpCubit build(AuthMode mode) => OtpCubit(
    verifyOtp: verifyOtp,
    requestOtp: requestOtp,
    phone: _phone,
    mode: mode,
  )..startCountdown();

  test('a wrong code counts an attempt, shakes and clears the boxes', () {
    fakeAsync((async) {
      final cubit = build(AuthMode.logIn)..changed('000000');
      async.flushMicrotasks();

      expect(cubit.state.attempts, 1);
      expect(cubit.state.status, OtpStatus.wrong);
      expect(cubit.state.shakeCount, 1);
      expect(cubit.state.code, isEmpty);
      expect(cubit.state.locked, isFalse);
      unawaited(cubit.close());
    });
  });

  test('the third wrong code locks entry and enables Resend', () {
    fakeAsync((async) {
      final cubit = build(AuthMode.logIn);
      for (var i = 0; i < AuthRules.maxOtpAttempts; i++) {
        cubit.changed('000000');
        async.flushMicrotasks();
      }

      expect(cubit.state.locked, isTrue);
      expect(cubit.state.canResend, isTrue);

      cubit.changed('1');
      expect(cubit.state.code, isEmpty, reason: 'locked entry ignores input');
      unawaited(cubit.close());
    });
  });

  test('Resend unlocks entry, restarts the countdown and asks for a code', () {
    fakeAsync((async) {
      final cubit = build(AuthMode.logIn);
      for (var i = 0; i < AuthRules.maxOtpAttempts; i++) {
        cubit.changed('000000');
        async.flushMicrotasks();
      }
      async.elapse(const Duration(seconds: 10));

      unawaited(cubit.resend());
      async.flushMicrotasks();

      expect(cubit.state.locked, isFalse);
      expect(cubit.state.attempts, 0);
      expect(cubit.state.remaining, AuthRules.resendCountdown);
      verify(() => requestOtp(any())).called(1);
      unawaited(cubit.close());
    });
  });

  test('Resend is unavailable until the countdown reaches zero', () {
    fakeAsync((async) {
      final cubit = build(AuthMode.logIn);

      async.elapse(const Duration(seconds: 299));
      expect(cubit.state.canResend, isFalse);

      async.elapse(const Duration(seconds: 1));
      expect(cubit.state.remaining, Duration.zero);
      expect(cubit.state.canResend, isTrue);
      unawaited(cubit.close());
    });
  });

  test('a code typed while verifying sends one request', () {
    fakeAsync((async) {
      final cubit = build(AuthMode.logIn)..changed('123456');
      unawaited(cubit.verify());
      async.flushMicrotasks();

      verify(() => verifyOtp(any())).called(1);
      unawaited(cubit.close());
    });
  });

  test('the right code in log-in mode returns the user', () {
    fakeAsync((async) {
      when(() => verifyOtp(any()))
          .thenAnswer((_) async => Success<UserVO?>(testUser));
      final cubit = build(AuthMode.logIn)..changed('123456');
      async.flushMicrotasks();

      expect(cubit.state.status, OtpStatus.verified);
      expect(cubit.state.user, testUser);
      unawaited(cubit.close());
    });
  });
}
