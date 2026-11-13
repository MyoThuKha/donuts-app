import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:donuts/features/auth/presentation/session/user_initials.dart';
import 'package:flutter_test/flutter_test.dart';

UserVO _user(String first, [String? last]) => UserVO(
  id: 1,
  phone: '+959254135592',
  firstName: first,
  lastName: last,
  dateOfBirth: DateTime(1980),
);

void main() {
  test('takes the first letter of the first and last names', () {
    expect(_user('Ye Min', 'Phyoe Win').initials, 'YP');
    expect(_user('mike').initials, 'M');
    expect(_user('Mike', '  ').initials, 'M');
  });
}
