import 'package:donuts/features/auth/domain/auth_rules.dart';
import 'package:donuts/features/auth/domain/validators/validation_result.dart';

final RegExp _separators = RegExp(r'[\s-]');
final RegExp _localWithOptionalZero = RegExp(r'^0?9\d{7,9}$');
final RegExp _subscriberNumber = RegExp(r'^9\d{7,9}$');
const String _countryDigits = '95';

/// Validates a Myanmar mobile number typed after the fixed +95 prefix and
/// returns it in E.164 form (`+959254135592`).
ValidationResult<String> validatePhone(String input) {
  var digits = input.replaceAll(_separators, '');
  if (digits.isEmpty) return const Invalid(ValidationError.empty);

  digits = _stripCountryCode(digits);
  if (digits.startsWith('0')) digits = digits.substring(1);

  return _subscriberNumber.hasMatch(digits)
      ? Valid('${AuthRules.countryCode}$digits')
      : const Invalid(ValidationError.invalidPhone);
}

/// Removes a pasted `+95`, or a bare `95` when the input isn't already a
/// local number on its own, so a local `95…` number keeps its digits.
String _stripCountryCode(String digits) {
  if (digits.startsWith(AuthRules.countryCode)) {
    return digits.substring(AuthRules.countryCode.length);
  }
  if (_localWithOptionalZero.hasMatch(digits)) return digits;
  final rest = digits.startsWith(_countryDigits)
      ? digits.substring(_countryDigits.length)
      : null;
  return rest != null && _localWithOptionalZero.hasMatch(rest) ? rest : digits;
}
