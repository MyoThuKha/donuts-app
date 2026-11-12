import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/domain/usecases/log_out_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/restore_session_use_case.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// App-wide sign-in state. The router's guard listens to it.
class SessionCubit extends Cubit<SessionState> {
  new({required this._restoreSession, required this._logOut})
    : super(const SessionSignedOut());

  final RestoreSessionUseCase _restoreSession;
  final LogOutUseCase _logOut;

  /// Reads the session saved by a previous launch. A failure leaves the
  /// user signed out, which sends them to Onboarding.
  Future<void> restore() async {
    if (await _restoreSession() case Success(data: final user?)) {
      emit(SessionSignedIn(user));
    }
  }

  void signedIn(UserVO user, {bool justRegistered = false}) =>
      emit(SessionSignedIn(user, justRegistered: justRegistered));

  void welcomeSeen() {
    if (state case SessionSignedIn(:final user)) emit(SessionSignedIn(user));
  }

  Future<void> logOut() async {
    await _logOut();
    emit(const SessionSignedOut());
  }
}
