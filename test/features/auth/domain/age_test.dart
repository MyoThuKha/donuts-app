import 'package:donuts/features/auth/domain/age.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final birthday = DateTime(1980, 5);

  test('the year counts from the birthday on', () {
    expect(ageOn(today: DateTime(2026, 5), birthday: birthday), 46);
  });

  test('the day before the birthday is still the year before', () {
    expect(ageOn(today: DateTime(2026, 4, 30), birthday: birthday), 45);
  });
}
