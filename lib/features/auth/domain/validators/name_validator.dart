import 'package:donuts/features/auth/domain/auth_rules.dart';
import 'package:donuts/features/auth/domain/validators/validation_result.dart';

/// Letters and combining marks of any script (Myanmar included) and spaces.
/// Digits of every script fall outside `\p{L}` and `\p{M}`.
final RegExp _nameCharacters = RegExp(r'^[\p{L}\p{M} ]+$', unicode: true);

ValidationResult<String> validateFirstName(String input) {
  final name = input.trim();
  if (name.isEmpty) return const Invalid(ValidationError.empty);
  return _checkCharacters(name);
}

/// Many Myanmar names have no family name, so an empty last name is valid
/// and returns `null`.
ValidationResult<String?> validateLastName(String input) {
  final name = input.trim();
  if (name.isEmpty) return const Valid(null);
  return switch (_checkCharacters(name)) {
    Valid(:final value) => Valid(value),
    Invalid(:final error) => Invalid(error),
  };
}

ValidationResult<String> _checkCharacters(String name) {
  if (name.runes.length > AuthRules.nameMaxLength) {
    return const Invalid(ValidationError.tooLong);
  }
  return _nameCharacters.hasMatch(name)
      ? Valid(name)
      : const Invalid(ValidationError.invalidCharacters);
}
