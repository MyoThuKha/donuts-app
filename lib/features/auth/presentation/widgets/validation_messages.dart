import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/features/auth/domain/auth_rules.dart';
import 'package:donuts/features/auth/domain/validators/validation_result.dart';

/// User-facing text for each [ValidationError].
extension ValidationMessages on AppLocalizations {
  String? phoneError(ValidationResult<String> result) => switch (result) {
    Valid() => null,
    Invalid() => phoneInvalid,
  };

  String? nameError(ValidationResult<Object?> result) => switch (result) {
    Valid() => null,
    Invalid(error: ValidationError.empty) => firstNameRequired,
    Invalid(error: ValidationError.tooLong) => nameTooLong(
      AuthRules.nameMaxLength,
    ),
    Invalid() => nameInvalid,
  };

  String? dateOfBirthError(ValidationResult<DateTime> result) =>
      switch (result) {
        Valid() || Invalid(error: ValidationError.incompleteDate) => null,
        Invalid(error: ValidationError.inFuture) => dobFuture,
        Invalid(error: ValidationError.tooYoung) => dobTooYoung(
          AuthRules.minimumAge,
        ),
        Invalid() => dobInvalid,
      };
}
