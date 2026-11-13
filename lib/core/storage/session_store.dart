import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Where the signed-in user's id survives app restarts.
abstract interface class SessionStore {
  Future<int?> readUserId();

  Future<void> writeUserId(int id);

  Future<void> clear();
}

class SecureSessionStore implements SessionStore {
  const new(this._storage);

  static const String userIdKey = 'session_user_id';

  final FlutterSecureStorage _storage;

  @override
  Future<int?> readUserId() async =>
      int.tryParse(await _storage.read(key: userIdKey) ?? '');

  @override
  Future<void> writeUserId(int id) =>
      _storage.write(key: userIdKey, value: '$id');

  @override
  Future<void> clear() => _storage.delete(key: userIdKey);
}
