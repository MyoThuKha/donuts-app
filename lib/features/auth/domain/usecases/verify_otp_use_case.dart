import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/domain/params/otp_params.dart';
import 'package:donuts/features/auth/domain/repositories/auth_repository.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';

class VerifyOtpUseCase {
  const new(this._auth);

  final AuthRepository _auth;

  Future<Result<UserVO?>> call(OtpVerificationParams params) =>
      _auth.verifyOtp(params.phone, params.code, params.mode);
}
