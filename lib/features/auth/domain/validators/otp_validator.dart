import 'package:donuts/features/auth/domain/auth_rules.dart';
import 'package:donuts/features/auth/domain/validators/validation_result.dart';

final RegExp _otp = RegExp('^\\d{${AuthRules.otpLength}}\$');

/// Checks the code's shape only. Whether it's the right code is the
/// repository's call.
ValidationResult<String> validateOtp(String input) => _otp.hasMatch(input)
    ? Valid(input)
    : const Invalid(ValidationError.incompleteOtp);
