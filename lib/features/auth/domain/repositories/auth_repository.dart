import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/domain/params/registration_params.dart';
import 'package:donuts/features/auth/domain/types/auth_mode.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';

/// Sign-up, log-in and session. A real API can replace the fake
/// implementation without touching presentation.
abstract interface class AuthRepository {
  /// Fails with `NotRegisteredFailure` when logging in with an unknown
  /// number, and `AlreadyRegisteredFailure` when registering a known one.
  Future<Result<void>> requestOtp(String phone, AuthMode mode);

  /// Fails with `WrongOtpFailure` for a wrong code. In log-in mode a right
  /// code signs the user in and returns them; in register mode it returns
  /// `null`, because the account doesn't exist yet.
  Future<Result<UserVO?>> verifyOtp(String phone, String code, AuthMode mode);

  /// Creates the account and signs the new user in.
  Future<Result<UserVO>> register(RegistrationParams params);

  /// The signed-in user from a previous launch, or `null`.
  Future<Result<UserVO?>> restoreSession();

  Future<Result<void>> logOut();
}
