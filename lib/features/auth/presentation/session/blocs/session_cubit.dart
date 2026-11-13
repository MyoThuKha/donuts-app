import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/domain/usecases/log_out_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/restore_session_use_case.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// App-wide sign-in state. The router's guard listens to it.
class SessionCubit extends Cubit<SessionState> {
  new({required this._restoreSession, required this._logOut})
    : super(const SessionSignedOut());

  final RestoreSessionUseCase _restoreSession;
  final LogOutUseCase _logOut;

  /// Reads the session saved by a previous launch. A failure leaves the
  /// user signed out, which sends them to Onboarding, and goes to
  /// [onError] for the logs.
  Future<void> restore() async {
    switch (await _restoreSession()) {
      case Success(data: final user?):
        emit(SessionSignedIn(user));
      case Success():
        break;
      case Failure(:final failure):
        _report(failure);
    }
  }

  void signedIn(UserVO user, {bool justRegistered = false}) =>
      emit(SessionSignedIn(user, justRegistered: justRegistered));

  void welcomeSeen() {
    if (state case SessionSignedIn(:final user)) emit(SessionSignedIn(user));
  }

  /// Clears the saved session, then signs out. Returns false and stays
  /// signed in when the session couldn't be cleared, because the next
  /// launch would restore it.
  Future<bool> logOut() async {
    if (await _logOut() case Failure(:final failure)) {
      _report(failure);
      return false;
    }
    if (!isClosed) emit(const SessionSignedOut());
    return true;
  }

  void _report(AppFailure failure) =>
      addError(failure, failure.stackTrace ?? StackTrace.current);

  @override
  void onError(Object error, StackTrace stackTrace) {
    final detail = error is AppFailure
        ? '${error.runtimeType} ${error.error}'
        : '$error';
    debugPrint('Session: $detail');
    super.onError(error, stackTrace);
  }
}
