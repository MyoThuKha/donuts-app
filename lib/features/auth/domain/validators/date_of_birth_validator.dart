import 'package:donuts/features/auth/domain/auth_rules.dart';
import 'package:donuts/features/auth/domain/validators/validation_result.dart';

const int _monthsInYear = 12;

ValidationResult<DateTime> validateDateOfBirth({
  required int? year,
  required int? month,
  required int? day,
  required DateTime today,
}) {
  if (year == null || month == null || day == null) {
    return const Invalid(ValidationError.incompleteDate);
  }
  final date = _realDate(year, month, day);
  if (date == null) return const Invalid(ValidationError.notARealDate);

  final todayDate = DateTime(today.year, today.month, today.day);
  if (date.isAfter(todayDate)) return const Invalid(ValidationError.inFuture);
  if (_ageOn(todayDate, date) < AuthRules.minimumAge) {
    return const Invalid(ValidationError.tooYoung);
  }
  return Valid(date);
}

/// `DateTime` rolls 31 April over to 1 May, so a date is real only when it
/// round-trips to the same parts.
DateTime? _realDate(int year, int month, int day) {
  if (month < 1 || month > _monthsInYear || day < 1) return null;
  final date = DateTime(year, month, day);
  final roundTrips =
      date.year == year && date.month == month && date.day == day;
  return roundTrips ? date : null;
}

int _ageOn(DateTime today, DateTime birthday) {
  final hadBirthdayThisYear =
      today.month > birthday.month ||
      (today.month == birthday.month && today.day >= birthday.day);
  return today.year - birthday.year - (hadBirthdayThisYear ? 0 : 1);
}
