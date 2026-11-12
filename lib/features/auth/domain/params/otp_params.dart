import 'package:donuts/features/auth/domain/types/auth_mode.dart';
import 'package:equatable/equatable.dart';

final class OtpRequestParams extends Equatable {
  const new({required this.phone, required this.mode});

  final String phone;
  final AuthMode mode;

  @override
  List<Object?> get props => [phone, mode];
}

final class OtpVerificationParams extends Equatable {
  const new({required this.phone, required this.code, required this.mode});

  final String phone;
  final String code;
  final AuthMode mode;

  @override
  List<Object?> get props => [phone, code, mode];
}
