import 'package:donuts/features/auth/domain/validators/date_of_birth_validator.dart';
import 'package:donuts/features/auth/domain/validators/validation_result.dart';
import 'package:flutter_test/flutter_test.dart';

final _today = DateTime(2026, 11, 12);

ValidationResult<DateTime> _check(int? year, int? month, int? day) =>
    validateDateOfBirth(year: year, month: month, day: day, today: _today);

Matcher _invalid(ValidationError error) =>
    isA<Invalid<DateTime>>().having((v) => v.error, 'error', error);

void main() {
  group('validateDateOfBirth', () {
    test('accepts a real past date', () {
      expect(
        _check(1980, 5, 1),
        isA<Valid<DateTime>>().having(
          (v) => v.value,
          'value',
          DateTime(1980, 5),
        ),
      );
    });

    test('accepts 29 February in a leap year', () {
      expect(_check(2004, 2, 29), isA<Valid<DateTime>>());
    });

    test('accepts someone turning 13 today', () {
      expect(_check(2013, 11, 12), isA<Valid<DateTime>>());
    });

    test('reports a missing field as incomplete', () {
      expect(_check(null, 5, 1), _invalid(ValidationError.incompleteDate));
      expect(_check(1980, null, 1), _invalid(ValidationError.incompleteDate));
      expect(_check(1980, 5, null), _invalid(ValidationError.incompleteDate));
    });

    test('rejects dates that do not exist', () {
      expect(_check(2025, 4, 31), _invalid(ValidationError.notARealDate));
      expect(_check(2023, 2, 29), _invalid(ValidationError.notARealDate));
      expect(_check(1900, 2, 29), _invalid(ValidationError.notARealDate));
      expect(_check(2000, 13, 1), _invalid(ValidationError.notARealDate));
      expect(_check(2000, 1, 0), _invalid(ValidationError.notARealDate));
    });

    test('rejects a year that would make someone older than any person', () {
      expect(_check(198, 5, 1), _invalid(ValidationError.notARealDate));
      expect(_check(1800, 5, 1), _invalid(ValidationError.notARealDate));
    });

    test('rejects a date after today', () {
      expect(_check(2026, 11, 13), _invalid(ValidationError.inFuture));
    });

    test('rejects someone who turns 13 tomorrow', () {
      expect(_check(2013, 11, 13), _invalid(ValidationError.tooYoung));
    });
  });
}
