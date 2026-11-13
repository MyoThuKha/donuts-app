import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/domain/repositories/auth_repository.dart';

/// Clears something that belongs to the signed-in member, such as their
/// cart, before the session ends.
typedef SignOutCleanup = Future<Result<void>> Function();

/// Runs each [SignOutCleanup] in order, then ends the session. The first
/// failure stops the log-out and is returned, and the session stays.
class LogOutUseCase {
  const new(this._auth, {this.cleanups = const []});

  final AuthRepository _auth;
  final List<SignOutCleanup> cleanups;

  Future<Result<void>> call() async {
    for (final cleanup in cleanups) {
      if (await cleanup() case final Failure<void> failure) return failure;
    }
    return await _auth.logOut();
  }
}
