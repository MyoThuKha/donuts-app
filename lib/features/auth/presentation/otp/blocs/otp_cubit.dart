import 'dart:async';

import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/domain/auth_rules.dart';
import 'package:donuts/features/auth/domain/params/otp_params.dart';
import 'package:donuts/features/auth/domain/types/auth_mode.dart';
import 'package:donuts/features/auth/domain/usecases/request_otp_use_case.dart';
import 'package:donuts/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:donuts/features/auth/domain/validators/otp_validator.dart';
import 'package:donuts/features/auth/domain/validators/validation_result.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:donuts/features/auth/presentation/otp/blocs/otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpCubit extends Cubit<OtpState> {
  new({
    required this._verifyOtp,
    required this._requestOtp,
    required this.phone,
    required this.mode,
  }) : super(const OtpState(remaining: AuthRules.resendCountdown));

  static const Duration _tick = Duration(seconds: 1);

  final VerifyOtpUseCase _verifyOtp;
  final RequestOtpUseCase _requestOtp;
  final String phone;
  final AuthMode mode;
  Timer? _timer;

  void startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(_tick, (_) => _onTick());
  }

  void _onTick() {
    final left = state.remaining - _tick;
    if (left <= Duration.zero) _timer?.cancel();
    emit(
      state.copyWith(remaining: left < Duration.zero ? Duration.zero : left),
    );
  }

  /// Takes the boxes' text and verifies once all six digits are in.
  void changed(String code) {
    if (state.locked || state.status == OtpStatus.verifying) return;
    emit(state.copyWith(code: code, status: OtpStatus.editing));
    if (validateOtp(code) is Valid) unawaited(verify());
  }

  Future<void> verify() async {
    if (state.status == OtpStatus.verifying || state.locked) return;
    emit(state.copyWith(status: OtpStatus.verifying));
    final result = await _verifyOtp(
      OtpVerificationParams(phone: phone, code: state.code, mode: mode),
    );
    if (isClosed) return;
    switch (result) {
      case Success(:final data):
        _onVerified(data);
      case Failure(failure: WrongOtpFailure()):
        _onWrongCode();
      case Failure():
        emit(state.copyWith(status: OtpStatus.failed));
    }
  }

  void _onVerified(UserVO? user) {
    _timer?.cancel();
    emit(state.copyWith(status: OtpStatus.verified, user: user));
  }

  void _onWrongCode() {
    final attempts = state.attempts + 1;
    emit(
      state.copyWith(
        code: '',
        attempts: attempts,
        locked: attempts >= AuthRules.maxOtpAttempts,
        status: OtpStatus.wrong,
        shakeCount: state.shakeCount + 1,
      ),
    );
  }

  /// Sends a new code, clears the attempts and restarts the countdown.
  Future<void> resend() async {
    if (!state.canResend) return;
    emit(
      OtpState(
        remaining: AuthRules.resendCountdown,
        shakeCount: state.shakeCount,
      ),
    );
    startCountdown();
    final result = await _requestOtp(
      OtpRequestParams(phone: phone, mode: mode),
    );
    if (!isClosed && result is Failure) {
      emit(state.copyWith(status: OtpStatus.failed));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
