import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/domain/repositories/auth_repository.dart';

class LogOutUseCase {
  const new(this._auth);

  final AuthRepository _auth;

  Future<Result<void>> call() => _auth.logOut();
}
