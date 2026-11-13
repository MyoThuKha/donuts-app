import 'dart:async';

import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/domain/types/auth_mode.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:donuts/features/auth/presentation/dob/blocs/dob_cubit.dart';
import 'package:donuts/features/auth/presentation/dob/blocs/dob_state.dart';
import 'package:donuts/features/auth/presentation/flow/blocs/registration_draft_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/fakes.dart';

void main() {
  setUpAll(registerAuthFallbacks);

  test('editing a field mid-request keeps the request the only one', () async {
    final register = MockRegisterUseCase();
    final pending = Completer<Result<UserVO>>();
    when(() => register(any())).thenAnswer((_) => pending.future);
    final draft = RegistrationDraftCubit(AuthMode.register)
      ..phoneEntered('09254135592', '+959254135592')
      ..namesEntered(firstName: 'Ye Min', lastName: '');
    final cubit = DobCubit(
      register: register,
      draft: draft,
      now: () => DateTime(2026, 11, 12),
    )..changed(day: 1, month: 5, year: 1980);

    unawaited(cubit.submit());
    cubit.changed(day: 2, month: 5, year: 1980);
    unawaited(cubit.submit());

    expect(cubit.state.status, DobStatus.submitting);
    verify(() => register(any())).called(1);
    pending.complete(Success(testUser));
    await cubit.close();
    await draft.close();
  });
}
