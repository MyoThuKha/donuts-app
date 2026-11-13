import 'dart:math';

import 'package:donuts/features/auth/domain/age.dart';
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
  final age = ageOn(today: todayDate, birthday: date);
  if (age > AuthRules.maximumAge) {
    return const Invalid(ValidationError.notARealDate);
  }
  if (age < AuthRules.minimumAge) {
    return const Invalid(ValidationError.tooYoung);
  }
  return Valid(date);
}

/// The earliest and latest dates of birth that [validateDateOfBirth]
/// accepts on [today], for limiting a date picker.
({DateTime earliest, DateTime latest}) dateOfBirthRange(DateTime today) => (
  earliest: _yearsBefore(today, AuthRules.maximumAge),
  latest: _yearsBefore(today, AuthRules.minimumAge),
);

/// The same month and day [years] before [today]. In a common year,
/// 29 February becomes the 28th instead of rolling over to 1 March.
DateTime _yearsBefore(DateTime today, int years) {
  final year = today.year - years;
  final lastDayOfMonth = DateTime(year, today.month + 1, 0).day;
  return DateTime(year, today.month, min(today.day, lastDayOfMonth));
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
