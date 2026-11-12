import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/storage/session_store.dart';
import 'package:donuts/features/auth/data/repositories/fake_auth_repository.dart';
import 'package:donuts/features/auth/domain/repositories/auth_repository.dart';
import 'package:donuts/features/auth/domain/usecases/log_out_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/register_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/request_otp_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/restore_session_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:donuts/features/auth/presentation/dob/blocs/dob_cubit.dart';
import 'package:donuts/features/auth/presentation/flow/blocs/registration_draft_cubit.dart';
import 'package:donuts/features/auth/presentation/flow/blocs/registration_draft_state.dart';
import 'package:donuts/features/auth/presentation/name/blocs/name_cubit.dart';
import 'package:donuts/features/auth/presentation/otp/blocs/otp_cubit.dart';
import 'package:donuts/features/auth/presentation/phone/blocs/phone_cubit.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:get_it/get_it.dart';

void registerAuthModule(GetIt getIt, {required Duration latency}) {
  getIt
    ..registerLazySingleton<AuthRepository>(
      () => FakeAuthRepository(
        users: getIt<AppDatabase>().usersDao,
        session: getIt<SessionStore>(),
        now: getIt<DateTime Function()>(),
        latency: latency,
      ),
    )
    ..registerLazySingleton(() => RequestOtpUseCase(getIt()))
    ..registerLazySingleton(() => VerifyOtpUseCase(getIt()))
    ..registerLazySingleton(() => RegisterUseCase(getIt()))
    ..registerLazySingleton(() => RestoreSessionUseCase(getIt()))
    ..registerLazySingleton(() => LogOutUseCase(getIt()))
    ..registerLazySingleton(
      () => SessionCubit(restoreSession: getIt(), logOut: getIt()),
      dispose: (cubit) => cubit.close(),
    );
  registerAuthStepCubits(getIt);
}

/// Step cubits are factories: each screen gets a fresh one, given the
/// flow's draft.
void registerAuthStepCubits(GetIt getIt) {
  getIt
    ..registerFactoryParam<PhoneCubit, RegistrationDraftCubit, void>(
      (draft, _) => PhoneCubit(requestOtp: getIt(), draft: draft),
    )
    ..registerFactoryParam<OtpCubit, RegistrationDraftState, void>(
      (draft, _) => OtpCubit(
        verifyOtp: getIt(),
        requestOtp: getIt(),
        phone: draft.phone ?? '',
        mode: draft.mode,
      ),
    )
    ..registerFactoryParam<NameCubit, RegistrationDraftCubit, void>(
      (draft, _) => NameCubit(draft: draft),
    )
    ..registerFactoryParam<DobCubit, RegistrationDraftCubit, void>(
      (draft, _) => DobCubit(register: getIt(), draft: draft, now: getIt()),
    );
}
