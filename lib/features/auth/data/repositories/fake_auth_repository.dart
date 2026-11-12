import 'package:donuts/core/database/daos/users_dao.dart';
import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/guard.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/storage/session_store.dart';
import 'package:donuts/features/auth/data/mapper/user_db_mapper.dart';
import 'package:donuts/features/auth/domain/params/registration_params.dart';
import 'package:donuts/features/auth/domain/repositories/auth_repository.dart';
import 'package:donuts/features/auth/domain/types/auth_mode.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';

/// Stands in for a real auth API: every call waits [latency], users live in
/// the local database and any phone accepts [validOtp].
class FakeAuthRepository implements AuthRepository {
  new({
    required this._users,
    required this._session,
    required this._now,
    this.latency = defaultLatency,
  });

  /// The one code the fake accepts. The README documents it.
  static const String validOtp = '123456';

  static const Duration defaultLatency = Duration(seconds: 1);

  final UsersDao _users;
  final SessionStore _session;
  final DateTime Function() _now;
  final Duration latency;

  @override
  Future<Result<void>> requestOtp(String phone, AuthMode mode) async {
    await _wait();
    final known = await guard(() => _users.findByPhone(phone));
    return switch (known) {
      Failure(:final failure) => Failure(failure),
      Success(:final data) when data == null && mode == AuthMode.logIn =>
        const Failure(NotRegisteredFailure()),
      Success(:final data) when data != null && mode == AuthMode.register =>
        const Failure(AlreadyRegisteredFailure()),
      Success() => const Success(null),
    };
  }

  @override
  Future<Result<UserVO?>> verifyOtp(
    String phone,
    String code,
    AuthMode mode,
  ) async {
    await _wait();
    if (code != validOtp) return const Failure(WrongOtpFailure());
    if (mode == AuthMode.register) return const Success(null);
    return await guard(() async {
      final row = await _users.findByPhone(phone);
      if (row == null) return null;
      await _session.writeUserId(row.id);
      return row.toVO();
    });
  }

  @override
  Future<Result<UserVO>> register(RegistrationParams params) async {
    await _wait();
    return await guard(() async {
      final id = await _users.insertUser(params.toCompanion(createdAt: _now()));
      await _session.writeUserId(id);
      return (await _users.findById(id))!.toVO();
    });
  }

  @override
  Future<Result<UserVO?>> restoreSession() => guard(() async {
    final id = await _session.readUserId();
    if (id == null) return null;
    final row = await _users.findById(id);
    if (row == null) await _session.clear();
    return row?.toVO();
  });

  @override
  Future<Result<void>> logOut() async {
    await _wait();
    return await guard(_session.clear);
  }

  Future<void> _wait() => Future<void>.delayed(latency);
}
