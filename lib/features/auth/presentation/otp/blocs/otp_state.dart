import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:equatable/equatable.dart';

enum OtpStatus { editing, verifying, wrong, verified, failed }

final class OtpState extends Equatable {
  const new({
    required this.remaining,
    this.code = '',
    this.attempts = 0,
    this.locked = false,
    this.status = OtpStatus.editing,
    this.shakeCount = 0,
    this.user,
  });

  final String code;

  /// Wrong codes since the last OTP was sent.
  final int attempts;

  /// Entry stays locked after too many wrong codes until Resend.
  final bool locked;

  /// Time left before Resend becomes available.
  final Duration remaining;
  final OtpStatus status;

  /// Bumped on each wrong code; the boxes shake when it changes.
  final int shakeCount;

  /// The signed-in user after a log-in OTP; `null` when registering.
  final UserVO? user;

  bool get canResend => remaining == Duration.zero || locked;

  OtpState copyWith({
    String? code,
    int? attempts,
    bool? locked,
    Duration? remaining,
    OtpStatus? status,
    int? shakeCount,
    UserVO? user,
  }) => OtpState(
    code: code ?? this.code,
    attempts: attempts ?? this.attempts,
    locked: locked ?? this.locked,
    remaining: remaining ?? this.remaining,
    status: status ?? this.status,
    shakeCount: shakeCount ?? this.shakeCount,
    user: user ?? this.user,
  );

  @override
  List<Object?> get props => [
    code,
    attempts,
    locked,
    remaining,
    status,
    shakeCount,
    user,
  ];
}
