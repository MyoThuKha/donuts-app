import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/domain/usecases/log_out_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/restore_session_use_case.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockRestoreSessionUseCase extends Mock implements RestoreSessionUseCase;

class MockLogOutUseCase extends Mock implements LogOutUseCase;

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
