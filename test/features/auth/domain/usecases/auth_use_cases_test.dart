import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/domain/params/otp_params.dart';
import 'package:donuts/features/auth/domain/params/registration_params.dart';
import 'package:donuts/features/auth/domain/types/auth_mode.dart';
import 'package:donuts/features/auth/domain/usecases/log_out_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/register_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/request_otp_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/restore_session_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/fakes.dart';

const String _phone = '+959254135592';
const String _code = '123456';

void main() {
  late MockAuthRepository auth;

  setUp(() => auth = MockAuthRepository());

  group('RequestOtpUseCase', () {
    test('asks the repository for a code for the phone and mode', () async {
      when(() => auth.requestOtp(_phone, AuthMode.logIn))
          .thenAnswer((_) async => const Success(null));

      final result = await RequestOtpUseCase(auth)(
        const OtpRequestParams(phone: _phone, mode: AuthMode.logIn),
      );

      expect(result, isA<Success<void>>());
      verify(() => auth.requestOtp(_phone, AuthMode.logIn)).called(1);
    });

    test('returns the repository failure for an unknown number', () async {
      when(() => auth.requestOtp(_phone, AuthMode.logIn))
          .thenAnswer((_) async => const Failure(NotRegisteredFailure()));

      final result = await RequestOtpUseCase(auth)(
        const OtpRequestParams(phone: _phone, mode: AuthMode.logIn),
      );

      expect(_failureOf(result), isA<NotRegisteredFailure>());
    });
  });

  group('VerifyOtpUseCase', () {
    const params = OtpVerificationParams(
      phone: _phone,
      code: _code,
      mode: AuthMode.logIn,
    );

    test('returns the signed-in user for a right code', () async {
      when(() => auth.verifyOtp(_phone, _code, AuthMode.logIn))
          .thenAnswer((_) async => Success(testUser));

      final result = await VerifyOtpUseCase(auth)(params);

      expect(_dataOf(result), testUser);
      verify(() => auth.verifyOtp(_phone, _code, AuthMode.logIn)).called(1);
    });

    test('returns no user in register mode, where no account exists '
        'yet', () async {
      when(() => auth.verifyOtp(_phone, _code, AuthMode.register))
          .thenAnswer((_) async => const Success<UserVO?>(null));

      final result = await VerifyOtpUseCase(auth)(
        const OtpVerificationParams(
          phone: _phone,
          code: _code,
          mode: AuthMode.register,
        ),
      );

      expect(_dataOf(result), isNull);
    });

    test('returns the repository failure for a wrong code', () async {
      when(() => auth.verifyOtp(_phone, _code, AuthMode.logIn))
          .thenAnswer((_) async => const Failure(WrongOtpFailure()));

      final result = await VerifyOtpUseCase(auth)(params);

      expect(_failureOf(result), isA<WrongOtpFailure>());
    });
  });

  group('RegisterUseCase', () {
    final params = RegistrationParams(
      phone: _phone,
      firstName: 'Ye Min',
      lastName: 'Phyoe Win',
      dateOfBirth: DateTime(1995, 6, 15),
    );

    test('creates the account and returns the new user', () async {
      when(() => auth.register(params))
          .thenAnswer((_) async => Success(testUser));

      final result = await RegisterUseCase(auth)(params);

      expect(_dataOf(result), testUser);
      verify(() => auth.register(params)).called(1);
    });

    test('returns the repository failure for a number that already has '
        'an account', () async {
      when(() => auth.register(params))
          .thenAnswer((_) async => const Failure(AlreadyRegisteredFailure()));

      final result = await RegisterUseCase(auth)(params);

      expect(_failureOf(result), isA<AlreadyRegisteredFailure>());
    });
  });

  group('RestoreSessionUseCase', () {
    test('returns the user signed in on a previous launch', () async {
      when(auth.restoreSession).thenAnswer((_) async => Success(testUser));

      expect(_dataOf(await RestoreSessionUseCase(auth)()), testUser);
    });

    test('returns no user when nobody is signed in', () async {
      when(auth.restoreSession)
          .thenAnswer((_) async => const Success<UserVO?>(null));

      expect(_dataOf(await RestoreSessionUseCase(auth)()), isNull);
    });

    test('returns the repository failure when the session cannot be '
        'read', () async {
      when(auth.restoreSession)
          .thenAnswer((_) async => const Failure(DatabaseFailure()));

      final result = await RestoreSessionUseCase(auth)();

      expect(_failureOf(result), isA<DatabaseFailure>());
    });
  });

  group('LogOutUseCase', () {
    test('ends the session through the repository', () async {
      when(auth.logOut).thenAnswer((_) async => const Success(null));

      final result = await LogOutUseCase(auth)();

      expect(result, isA<Success<void>>());
      verify(auth.logOut).called(1);
    });

    test('returns the repository failure when the session cannot be '
        'cleared', () async {
      when(auth.logOut)
          .thenAnswer((_) async => const Failure(UnknownFailure()));

      final result = await LogOutUseCase(auth)();

      expect(_failureOf(result), isA<UnknownFailure>());
    });

    test('log out runs the cleanups before clearing the session', () async {
      final calls = <String>[];
      when(auth.logOut).thenAnswer((_) async {
        calls.add('session');
        return const Success(null);
      });

      final result = await LogOutUseCase(
        auth,
        cleanups: [
          () async {
            calls.add('cart');
            return const Success(null);
          },
        ],
      )();

      expect(result, isA<Success<void>>());
      expect(calls, ['cart', 'session']);
    });

    test(
      'a failed cleanup returns its failure and keeps the session',
      () async {
        var secondRan = false;

        final result = await LogOutUseCase(
          auth,
          cleanups: [
            () async => const Failure(DatabaseFailure()),
            () async {
              secondRan = true;
              return const Success(null);
            },
          ],
        )();

        expect(_failureOf(result), isA<DatabaseFailure>());
        expect(secondRan, isFalse);
        verifyNever(auth.logOut);
      },
    );
  });
}

T _dataOf<T>(Result<T> result) => switch (result) {
  Success(:final data) => data,
  Failure(:final failure) => throw TestFailure('Expected data, got $failure'),
};

AppFailure _failureOf<T>(Result<T> result) => switch (result) {
  Failure(:final failure) => failure,
  Success(:final data) => throw TestFailure('Expected a failure, got $data'),
};
