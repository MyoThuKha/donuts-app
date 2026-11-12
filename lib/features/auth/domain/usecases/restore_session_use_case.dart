import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/domain/repositories/auth_repository.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';

class RestoreSessionUseCase {
  const new(this._auth);

  final AuthRepository _auth;

  Future<Result<UserVO?>> call() => _auth.restoreSession();
}
