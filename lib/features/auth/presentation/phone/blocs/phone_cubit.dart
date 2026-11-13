import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/domain/params/otp_params.dart';
import 'package:donuts/features/auth/domain/usecases/request_otp_use_case.dart';
import 'package:donuts/features/auth/domain/validators/phone_validator.dart';
import 'package:donuts/features/auth/presentation/flow/blocs/registration_draft_cubit.dart';
import 'package:donuts/features/auth/presentation/phone/blocs/phone_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneCubit extends Cubit<PhoneState> {
  new({required this._requestOtp, required this._draft})
    : super(
        PhoneState(
          input: _draft.state.phoneInput,
          validation: validatePhone(_draft.state.phoneInput),
        ),
      );

  final RequestOtpUseCase _requestOtp;
  final RegistrationDraftCubit _draft;

  void changed(String input) {
    final validation = validatePhone(input);
    final next = state.copyWith(
      input: input,
      validation: validation,
      status: PhoneStatus.editing,
    );
    emit(next);
    _draft.phoneEntered(input, next.phone);
  }

  void blurred() => emit(state.copyWith(showError: true));

  /// Requests an OTP and returns true when one was sent. Ignored while a
  /// request is already running, so a double tap sends one.
  Future<bool> submit() async {
    final phone = state.phone;
    if (phone == null || state.status == PhoneStatus.submitting) return false;
    emit(state.copyWith(status: PhoneStatus.submitting));
    final mode = _draft.state.mode;
    final result = await _requestOtp(
      OtpRequestParams(phone: phone, mode: mode),
    );
    if (isClosed) return false;
    emit(state.copyWith(status: _statusFor(result)));
    return result is Success;
  }

  PhoneStatus _statusFor(Result<void> result) => switch (result) {
    Success() => PhoneStatus.editing,
    Failure(failure: NotRegisteredFailure()) => PhoneStatus.notRegistered,
    Failure(failure: AlreadyRegisteredFailure()) =>
      PhoneStatus.alreadyRegistered,
    Failure() => PhoneStatus.failed,
  };
}
