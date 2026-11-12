import 'package:equatable/equatable.dart';

final class UserVO extends Equatable {
  const new({
    required this.id,
    required this.phone,
    required this.firstName,
    required this.dateOfBirth,
    this.lastName,
  });

  final int id;

  /// E.164, for example `+959254135592`.
  final String phone;
  final String firstName;
  final String? lastName;
  final DateTime dateOfBirth;

  String get displayName =>
      lastName == null ? firstName : '$firstName $lastName';

  @override
  List<Object?> get props => [id, phone, firstName, lastName, dateOfBirth];
}
