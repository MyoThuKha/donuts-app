import 'package:donuts/core/storage/language_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockStorage extends Mock implements FlutterSecureStorage;

void main() {
  late _MockStorage storage;
  late List<FlutterErrorDetails> reported;

  setUp(() {
    storage = _MockStorage();
    reported = [];
    final previous = FlutterError.onError;
    FlutterError.onError = reported.add;
    addTearDown(() => FlutterError.onError = previous);
  });

  final locked = PlatformException(code: 'keychain', message: 'locked');

  test('a failed read falls back to the device language and reports the '
      'failure', () async {
    when(() => storage.read(key: any(named: 'key'))).thenThrow(locked);

    final code = await SecureLanguageStore(storage).readCode();

    expect(code, isNull);
    expect(reported.single.exception, locked);
  });

  test('a failed write is reported', () async {
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenThrow(locked);

    await SecureLanguageStore(storage).writeCode('my');

    expect(reported.single.exception, locked);
  });
}
