import 'package:donuts/features/auth/domain/validators/phone_validator.dart';
import 'package:donuts/features/auth/domain/validators/validation_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('validatePhone', () {
    void expectNormalised(String input) {
      expect(
        validatePhone(input),
        isA<Valid<String>>().having((v) => v.value, 'value', '+959254135592'),
        reason: input,
      );
    }

    void expectError(String input, ValidationError error) {
      expect(
        validatePhone(input),
        isA<Invalid<String>>().having((v) => v.error, 'error', error),
        reason: input,
      );
    }

    test('normalises a local number with its leading zero to E.164', () {
      expectNormalised('09254135592');
    });

    test('accepts a number typed without the leading zero', () {
      expectNormalised('9254135592');
    });

    test('ignores spaces and dashes', () {
      expectNormalised('09-254 135 592');
    });

    test('accepts a pasted number that already carries +95', () {
      expectNormalised('+95 9254135592');
      expectNormalised('959254135592');
    });

    test('keeps a local number that starts with 95 as typed', () {
      expect(
        validatePhone('9591234567'),
        isA<Valid<String>>().having((v) => v.value, 'value', '+959591234567'),
      );
    });

    test('accepts 9 followed by 7 or 9 digits', () {
      expect(validatePhone('0912345678'), isA<Valid<String>>());
      expect(validatePhone('09123456789'), isA<Valid<String>>());
    });

    test('reports an empty field as empty', () {
      expectError('', ValidationError.empty);
      expectError('  ', ValidationError.empty);
    });

    test('rejects too few or too many digits after the 9', () {
      expectError('0912345', ValidationError.invalidPhone);
      expectError('091234567890', ValidationError.invalidPhone);
    });

    test('rejects numbers that do not start with 9', () {
      expectError('0812345678', ValidationError.invalidPhone);
    });

    test('strips only one leading zero', () {
      expectError('009254135592', ValidationError.invalidPhone);
    });

    test('rejects letters', () {
      expectError('09254a35592', ValidationError.invalidPhone);
    });
  });
}
