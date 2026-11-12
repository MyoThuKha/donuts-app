import 'dart:io';

import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/sync/data/catalog_importer.dart';
import 'package:donuts/core/sync/data/catalog_remote_data_source.dart';
import 'package:donuts/core/sync/data/catalog_sync_repository_impl.dart';
import 'package:donuts/core/sync/domain/sync_outcome.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/file_seed_source.dart';
import '../../../helpers/scripted_adapter.dart';
import '../../../helpers/seed_files.dart';

void main() {
  late AppDatabase db;
  late FileSeedSource seed;
  final remoteBody = File(remoteCatalogPath).readAsStringSync();

  CatalogSyncRepositoryImpl repositoryReplying(List<ScriptedReply> replies) =>
      CatalogSyncRepositoryImpl(
        seed: seed,
        remote: CatalogRemoteDataSource(scriptedDio(ScriptedAdapter(replies))),
        importer: CatalogImporter(db, now: () => DateTime.utc(2026, 11, 12)),
      );

  Future<int> productCount() async =>
      (await db.select(db.productsTable).get()).length;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    seed = FileSeedSource();
  });
  tearDown(() => db.close());

  test('seedIfNeeded on an empty database imports the catalog and the member '
      'data', () async {
    final result = await repositoryReplying(const []).seedIfNeeded();

    expect(result, isA<Success<void>>());
    expect(await productCount(), 8);
    expect((await db.memberDao.watchProfile().first)?.totalPoints, 680000);
  });

  test('seedIfNeeded twice loads the seed files once', () async {
    final repository = repositoryReplying(const []);

    await repository.seedIfNeeded();
    await repository.seedIfNeeded();

    expect(seed.loads, 2);
  });

  test('refresh online adds the remote product and returns updated', () async {
    final repository = repositoryReplying([ScriptedResponse(200, remoteBody)]);
    await repository.seedIfNeeded();

    final result = await repository.refreshCatalog();

    expect(
      result,
      isA<Success<SyncOutcome>>().having(
        (s) => s.data,
        'data',
        SyncOutcome.updated,
      ),
    );
    expect(await productCount(), 9);
  });

  test('refresh of the same version returns upToDate', () async {
    final repository = repositoryReplying([ScriptedResponse(200, remoteBody)]);
    await repository.refreshCatalog();

    final result = await repository.refreshCatalog();

    expect(
      result,
      isA<Success<SyncOutcome>>().having(
        (s) => s.data,
        'data',
        SyncOutcome.upToDate,
      ),
    );
  });

  test('refresh while the network is down returns NetworkFailure and keeps '
      'the seeded catalog', () async {
    final repository = repositoryReplying(const [ScriptedSocketFailure()]);
    await repository.seedIfNeeded();

    final result = await repository.refreshCatalog();

    expect(
      result,
      isA<Failure<SyncOutcome>>().having(
        (f) => f.failure,
        'failure',
        isA<NetworkFailure>(),
      ),
    );
    expect(await productCount(), 8);
  });

  test('refresh that receives HTML keeps the cached catalog', () async {
    final repository = repositoryReplying(const [
      ScriptedResponse(200, '<html>Sign in to Wi-Fi</html>'),
    ]);
    await repository.seedIfNeeded();

    final result = await repository.refreshCatalog();

    expect(
      result,
      isA<Failure<SyncOutcome>>().having(
        (f) => f.failure,
        'failure',
        isA<ParsingFailure>(),
      ),
    );
    expect(await productCount(), 8);
  });
}
