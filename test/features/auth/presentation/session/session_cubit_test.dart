import 'package:bloc_test/bloc_test.dart';
import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/fakes.dart';

void main() {
  blocTest<SessionCubit, SessionState>(
    'restore signs in the user saved by a previous launch',
    build: () => testSessionCubit(restored: testUser),
    act: (cubit) => cubit.restore(),
    expect: () => [SessionSignedIn(testUser)],
  );

  blocTest<SessionCubit, SessionState>(
    'restore stays signed out when nothing was saved',
    build: testSessionCubit,
    act: (cubit) => cubit.restore(),
    expect: () => <SessionState>[],
    verify: (cubit) => expect(cubit.state, const SessionSignedOut()),
  );

  blocTest<SessionCubit, SessionState>(
    'log out returns to signed out',
    build: () => testSessionCubit(restored: testUser),
    seed: () => SessionSignedIn(testUser),
    act: (cubit) => cubit.logOut(),
    expect: () => [const SessionSignedOut()],
  );

  blocTest<SessionCubit, SessionState>(
    'restore stays signed out and reports the failure when storage fails',
    build: () =>
        testSessionCubit(restoreResult: const Failure(DatabaseFailure())),
    act: (cubit) => cubit.restore(),
    expect: () => <SessionState>[],
    errors: () => [isA<DatabaseFailure>()],
  );

  test('log out reports success once signed out', () async {
    final cubit = testSessionCubit()..signedIn(testUser);
    addTearDown(cubit.close);

    expect(await cubit.logOut(), isTrue);
    expect(cubit.state, const SessionSignedOut());
  });

  blocTest<SessionCubit, SessionState>(
    'log out stays signed in and reports the failure when the session '
    "can't be cleared, so the next launch doesn't sign the user back in",
    build: () =>
        testSessionCubit(logOutResult: const Failure(UnknownFailure())),
    seed: () => SessionSignedIn(testUser),
    act: (cubit) async => expect(await cubit.logOut(), isFalse),
    expect: () => <SessionState>[],
    errors: () => [isA<UnknownFailure>()],
    verify: (cubit) => expect(cubit.state, SessionSignedIn(testUser)),
  );

  blocTest<SessionCubit, SessionState>(
    'seeing Welcome clears the just-registered flag',
    build: testSessionCubit,
    seed: () => SessionSignedIn(testUser, justRegistered: true),
    act: (cubit) => cubit.welcomeSeen(),
    expect: () => [SessionSignedIn(testUser)],
  );
}
