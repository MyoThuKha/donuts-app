import 'package:equatable/equatable.dart';

final class RegistrationParams extends Equatable {
  const new({
    required this.phone,
    required this.firstName,
    required this.dateOfBirth,
    this.lastName,
  });

  final String phone;
  final String firstName;
  final String? lastName;
  final DateTime dateOfBirth;

  @override
  List<Object?> get props => [phone, firstName, lastName, dateOfBirth];
}
