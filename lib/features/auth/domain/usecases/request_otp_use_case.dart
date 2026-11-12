import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/domain/params/otp_params.dart';
import 'package:donuts/features/auth/domain/repositories/auth_repository.dart';

class RequestOtpUseCase {
  const new(this._auth);

  final AuthRepository _auth;

  Future<Result<void>> call(OtpRequestParams params) =>
      _auth.requestOtp(params.phone, params.mode);
}
