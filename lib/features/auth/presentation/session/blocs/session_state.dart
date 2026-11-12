import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:equatable/equatable.dart';

sealed class SessionState extends Equatable {
  const new();
}

final class SessionSignedOut extends SessionState {
  const new();

  @override
  List<Object?> get props => [];
}

final class SessionSignedIn extends SessionState {
  const new(this.user, {this.justRegistered = false});

  final UserVO user;

  /// True from registration until the user leaves Welcome, so the router
  /// shows Welcome once instead of going straight to Home.
  final bool justRegistered;

  @override
  List<Object?> get props => [user, justRegistered];
}
