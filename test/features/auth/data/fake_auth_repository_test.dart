import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/data/repositories/fake_auth_repository.dart';
import 'package:donuts/features/auth/domain/params/registration_params.dart';
import 'package:donuts/features/auth/domain/types/auth_mode.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/memory_session_store.dart';

const _phone = '+959254135592';

final _params = RegistrationParams(
  phone: _phone,
  firstName: 'Ye Min',
  lastName: 'Phyoe Win',
  dateOfBirth: DateTime(1980, 5),
);

Matcher _failsWith<T>() =>
    isA<Failure<Object?>>().having((f) => f.failure, 'failure', isA<T>());

void main() {
  late AppDatabase db;
  late MemorySessionStore session;
  late FakeAuthRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    session = MemorySessionStore();
    repository = FakeAuthRepository(
      users: db.usersDao,
      session: session,
      latency: Duration.zero,
      now: () => DateTime(2026, 11, 12),
    );
  });

  tearDown(() => db.close());

  Future<UserVO> registered() async =>
      (await repository.register(_params) as Success<UserVO>).data;

  test(
    'log-in OTP request for an unknown number fails as not registered',
    () async {
      expect(
        await repository.requestOtp(_phone, AuthMode.logIn),
        _failsWith<NotRegisteredFailure>(),
      );
    },
  );

  test(
    'register OTP request for a known number fails as already registered',
    () async {
      await registered();

      expect(
        await repository.requestOtp(_phone, AuthMode.register),
        _failsWith<AlreadyRegisteredFailure>(),
      );
    },
  );

  test('a wrong OTP fails as wrong OTP', () async {
    expect(
      await repository.verifyOtp(_phone, '000000', AuthMode.register),
      _failsWith<WrongOtpFailure>(),
    );
  });

  test('the right OTP in register mode succeeds without signing in', () async {
    final result = await repository.verifyOtp(
      _phone,
      FakeAuthRepository.validOtp,
      AuthMode.register,
    );

    expect(result, isA<Success<UserVO?>>().having((s) => s.data, 'data', null));
    expect(session.userId, isNull);
  });

  test('the right OTP in log-in mode for a number with no user fails as '
      'not registered and signs nobody in', () async {
    expect(
      await repository.verifyOtp(
        _phone,
        FakeAuthRepository.validOtp,
        AuthMode.logIn,
      ),
      _failsWith<NotRegisteredFailure>(),
    );
    expect(session.userId, isNull);
  });

  test('register stores the user and restores them as the session', () async {
    final user = await registered();

    expect(user.firstName, 'Ye Min');
    expect(user.lastName, 'Phyoe Win');
    expect(session.userId, user.id);
    expect(
      await repository.restoreSession(),
      isA<Success<UserVO?>>().having((s) => s.data, 'data', user),
    );
  });

  test('the right OTP in log-in mode signs the stored user in', () async {
    final user = await registered();
    await session.clear();

    final result = await repository.verifyOtp(
      _phone,
      FakeAuthRepository.validOtp,
      AuthMode.logIn,
    );

    expect(result, isA<Success<UserVO?>>().having((s) => s.data, 'data', user));
    expect(session.userId, user.id);
  });

  test('log out clears the session', () async {
    await registered();

    await repository.logOut();

    expect(session.userId, isNull);
    expect(
      await repository.restoreSession(),
      isA<Success<UserVO?>>().having((s) => s.data, 'data', null),
    );
  });

  test('a session pointing at a missing user is cleared on restore', () async {
    session.userId = 42;

    final result = await repository.restoreSession();

    expect(result, isA<Success<UserVO?>>().having((s) => s.data, 'data', null));
    expect(session.userId, isNull);
  });
}
