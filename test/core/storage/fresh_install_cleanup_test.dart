import 'dart:io';

import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/storage/fresh_install_cleanup.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_language_store.dart';
import '../../helpers/memory_session_store.dart';

void main() {
  late MemorySessionStore session;
  late FakeLanguageStore language;

  setUp(() {
    session = MemorySessionStore()..userId = 7;
    language = FakeLanguageStore('my');
  });

  FreshInstallCleanup cleanupFor(AppDatabase database) => FreshInstallCleanup(
    database: database,
    session: session,
    language: language,
  );

  test('a database created on this launch clears the session and language '
      'an earlier install left in secure storage', () async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);

    final result = await cleanupFor(database).run();

    expect(result, isA<Success<bool>>().having((s) => s.data, 'data', true));
    expect(session.userId, isNull);
    expect(language.code, isNull);
  });

  test('a database kept from an earlier launch leaves the session and '
      'language alone', () async {
    final dir = await Directory.systemTemp.createTemp('fresh_install');
    addTearDown(() => dir.delete(recursive: true));
    final file = File('${dir.path}/donuts.sqlite');
    final firstLaunch = AppDatabase.forTesting(NativeDatabase(file));
    await cleanupFor(firstLaunch).run();
    await firstLaunch.close();
    session.userId = 7;
    language.code = 'my';

    final database = AppDatabase.forTesting(NativeDatabase(file));
    addTearDown(database.close);
    final result = await cleanupFor(database).run();

    expect(result, isA<Success<bool>>().having((s) => s.data, 'data', false));
    expect(session.userId, 7);
    expect(language.code, 'my');
  });

  test('a session store that fails to clear returns a failure', () async {
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(database.close);
    final cleanup = FreshInstallCleanup(
      database: database,
      session: _FailingSessionStore(),
      language: language,
    );

    final result = await cleanup.run();

    expect(
      result,
      isA<Failure<bool>>().having(
        (f) => f.failure,
        'failure',
        isA<UnknownFailure>(),
      ),
    );
  });
}

class _FailingSessionStore extends MemorySessionStore {
  @override
  Future<void> clear() async =>
      throw PlatformException(code: 'keychain', message: 'locked');
}
