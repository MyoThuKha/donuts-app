import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Where the member's language choice survives app restarts.
abstract interface class LanguageStore {
  /// The stored language code, or null when the app follows the device.
  Future<String?> readCode();

  /// Stores [code]. Null clears it, so the app follows the device again.
  Future<void> writeCode(String? code);
}

/// Keeps the choice in secure storage, the app's only key-value store.
///
/// A language is a preference, not data, so a storage error falls back to
/// the device language instead of reaching the UI.
class SecureLanguageStore implements LanguageStore {
  const new(this._storage);

  static const String codeKey = 'app_language';

  final FlutterSecureStorage _storage;

  @override
  Future<String?> readCode() async {
    try {
      return await _storage.read(key: codeKey);
    } on PlatformException catch (error) {
      debugPrint('Reading the language failed: $error');
      return null;
    }
  }

  @override
  Future<void> writeCode(String? code) async {
    try {
      if (code == null) {
        await _storage.delete(key: codeKey);
      } else {
        await _storage.write(key: codeKey, value: code);
      }
    } on PlatformException catch (error) {
      debugPrint('Saving the language failed: $error');
    }
  }
}
