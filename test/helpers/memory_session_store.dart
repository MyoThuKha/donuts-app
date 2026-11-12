import 'package:donuts/core/storage/session_store.dart';

/// In-memory [SessionStore] for tests.
class MemorySessionStore implements SessionStore {
  int? userId;

  @override
  Future<int?> readUserId() async => userId;

  @override
  Future<void> writeUserId(int id) async => userId = id;

  @override
  Future<void> clear() async => userId = null;
}
