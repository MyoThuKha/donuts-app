import 'package:donuts/features/auth/domain/validators/name_validator.dart';
import 'package:donuts/features/auth/domain/validators/otp_validator.dart';
import 'package:donuts/features/auth/domain/validators/validation_result.dart';
import 'package:flutter_test/flutter_test.dart';

Matcher _invalid(ValidationError error) =>
    isA<Invalid<dynamic>>().having((v) => v.error, 'error', error);

Matcher _valid(Object? value) =>
    isA<Valid<dynamic>>().having((v) => v.value, 'value', value);

void main() {
  group('validateOtp', () {
    test('accepts exactly six digits', () {
      expect(validateOtp('123456'), _valid('123456'));
    });

    test('reports anything else as incomplete', () {
      for (final input in ['', '12345', '1234567', '12a456']) {
        expect(validateOtp(input), _invalid(ValidationError.incompleteOtp));
      }
    });
  });

  group('validateFirstName', () {
    test('trims surrounding spaces', () {
      expect(validateFirstName('  Ye Min  '), _valid('Ye Min'));
    });

    test('accepts Myanmar script with combining marks', () {
      expect(validateFirstName('ရဲမင်း'), _valid('ရဲမင်း'));
    });

    test('accepts exactly 50 letters', () {
      expect(validateFirstName('a' * 50), isA<Valid<String>>());
    });

    test('rejects 51 letters as too long', () {
      expect(validateFirstName('a' * 51), _invalid(ValidationError.tooLong));
    });

    test('requires a first name', () {
      expect(validateFirstName(''), _invalid(ValidationError.empty));
      expect(validateFirstName('   '), _invalid(ValidationError.empty));
    });

    test('rejects digits in any script, and punctuation', () {
      for (final input in ['Ye2', 'Ye-Min', 'ရဲ၁', 'Ye_Min']) {
        expect(
          validateFirstName(input),
          _invalid(ValidationError.invalidCharacters),
          reason: input,
        );
      }
    });
  });

  group('validateLastName', () {
    test('treats an empty last name as none', () {
      expect(validateLastName(''), _valid(null));
      expect(validateLastName('  '), _valid(null));
    });

    test('accepts letters and spaces', () {
      expect(validateLastName('Phyoe Win'), _valid('Phyoe Win'));
    });

    test('applies the first-name character and length rules', () {
      expect(
        validateLastName('Win9'),
        _invalid(ValidationError.invalidCharacters),
      );
      expect(validateLastName('a' * 51), _invalid(ValidationError.tooLong));
    });
  });
}
