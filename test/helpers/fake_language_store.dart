import 'package:donuts/core/storage/language_store.dart';

/// An in-memory [LanguageStore] that records what was written.
class FakeLanguageStore implements LanguageStore {
  new([this.code]);

  String? code;

  @override
  Future<String?> readCode() async => code;

  @override
  Future<void> writeCode(String? code) async => this.code = code;
}
