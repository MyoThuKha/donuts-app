import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/result/guard.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/storage/language_store.dart';
import 'package:donuts/core/storage/session_store.dart';

/// Forgets what an earlier install left in secure storage.
///
/// iOS keeps keychain entries when the app is deleted, but deletes the
/// database with the app. So a database created on this launch means a new
/// install, and a saved session or language belongs to the old one.
class FreshInstallCleanup {
  const new({
    required this._database,
    required this._session,
    required this._language,
  });

  final AppDatabase _database;
  final SessionStore _session;
  final LanguageStore _language;

  /// Clears the saved session and language on a new install. The result is
  /// true when it cleared them.
  Future<Result<bool>> run() => guard(() async {
    if (!await _database.createdOnThisLaunch()) return false;
    await _session.clear();
    await _language.writeCode(null);
    return true;
  });
}
