import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/storage/session_store.dart';
import 'package:donuts/features/auth/data/repositories/fake_auth_repository.dart';
import 'package:donuts/features/auth/domain/repositories/auth_repository.dart';
import 'package:donuts/features/auth/domain/usecases/log_out_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/register_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/request_otp_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/restore_session_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/verify_otp_use_case.dart';
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
    ..registerLazySingleton(() => LogOutUseCase(getIt()));
}
