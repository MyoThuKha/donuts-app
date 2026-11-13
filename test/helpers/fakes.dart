import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/sync/domain/usecases/refresh_catalog_use_case.dart';
import 'package:donuts/features/auth/domain/params/otp_params.dart';
import 'package:donuts/features/auth/domain/params/registration_params.dart';
import 'package:donuts/features/auth/domain/repositories/auth_repository.dart';
import 'package:donuts/features/auth/domain/types/auth_mode.dart';
import 'package:donuts/features/auth/domain/usecases/log_out_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/register_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/request_otp_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/restore_session_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository;

class MockRestoreSessionUseCase extends Mock implements RestoreSessionUseCase;

class MockLogOutUseCase extends Mock implements LogOutUseCase;

class MockRequestOtpUseCase extends Mock implements RequestOtpUseCase;

class MockVerifyOtpUseCase extends Mock implements VerifyOtpUseCase;

class MockRegisterUseCase extends Mock implements RegisterUseCase;

class MockRefreshCatalogUseCase extends Mock implements RefreshCatalogUseCase;

/// Call once in `setUpAll` before stubbing use cases with `any()`.
void registerAuthFallbacks() {
  registerFallbackValue(
    const OtpRequestParams(phone: '', mode: AuthMode.register),
  );
  registerFallbackValue(
    const OtpVerificationParams(phone: '', code: '', mode: AuthMode.register),
  );
  registerFallbackValue(
    RegistrationParams(phone: '', firstName: '', dateOfBirth: DateTime(2000)),
  );
}

final UserVO testUser = UserVO(
  id: 1,
  phone: '+959254135592',
  firstName: 'Ye Min',
  lastName: 'Phyoe Win',
  dateOfBirth: DateTime(1980, 5),
);

/// A [SessionCubit] whose use cases succeed: restore finds [restored] and
/// log out clears it.
SessionCubit testSessionCubit({UserVO? restored}) {
  final restore = MockRestoreSessionUseCase();
  final logOut = MockLogOutUseCase();
  when(restore.call).thenAnswer((_) async => Success(restored));
  when(logOut.call).thenAnswer((_) async => const Success(null));
  return SessionCubit(restoreSession: restore, logOut: logOut);
}
