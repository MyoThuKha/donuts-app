import 'package:donuts/features/auth/domain/types/auth_mode.dart';
import 'package:equatable/equatable.dart';

/// What the user has typed so far, kept while they move between steps.
final class RegistrationDraftState extends Equatable {
  const new({
    required this.mode,
    this.phoneInput = '',
    this.phone,
    this.firstName = '',
    this.lastName = '',
    this.day,
    this.month,
    this.year,
  });

  final AuthMode mode;

  /// The phone field's text, as typed.
  final String phoneInput;

  /// The number in E.164, once it validates.
  final String? phone;
  final String firstName;
  final String lastName;
  final int? day;
  final int? month;
  final int? year;

  /// Total steps for the progress ring: phone, OTP, name, date of birth when
  /// registering; phone and OTP when logging in.
  int get stepCount => mode == AuthMode.register ? 4 : 2;

  RegistrationDraftState copyWith({
    String? phoneInput,
    String? Function()? phone,
    String? firstName,
    String? lastName,
    int? Function()? day,
    int? Function()? month,
    int? Function()? year,
  }) => RegistrationDraftState(
    mode: mode,
    phoneInput: phoneInput ?? this.phoneInput,
    phone: phone == null ? this.phone : phone(),
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    day: day == null ? this.day : day(),
    month: month == null ? this.month : month(),
    year: year == null ? this.year : year(),
  );

  @override
  List<Object?> get props => [
    mode,
    phoneInput,
    phone,
    firstName,
    lastName,
    day,
    month,
    year,
  ];
}
