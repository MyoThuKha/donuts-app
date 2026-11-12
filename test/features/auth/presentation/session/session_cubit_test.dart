import 'package:bloc_test/bloc_test.dart';
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
    'seeing Welcome clears the just-registered flag',
    build: testSessionCubit,
    seed: () => SessionSignedIn(testUser, justRegistered: true),
    act: (cubit) => cubit.welcomeSeen(),
    expect: () => [SessionSignedIn(testUser)],
  );
}
