import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/sync/domain/catalog_sync_repository.dart';
import 'package:donuts/core/sync/domain/sync_outcome.dart';
import 'package:donuts/core/sync/domain/usecases/refresh_catalog_use_case.dart';
import 'package:donuts/core/sync/domain/usecases/seed_local_data_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements CatalogSyncRepository;

void main() {
  late _MockRepository repository;

  setUp(() => repository = _MockRepository());

  test('SeedLocalDataUseCase seeds through the repository', () async {
    when(repository.seedIfNeeded).thenAnswer((_) async => const Success(null));

    final result = await SeedLocalDataUseCase(repository)();

    expect(result, isA<Success<void>>());
    verify(repository.seedIfNeeded).called(1);
  });

  test('RefreshCatalogUseCase returns the repository outcome', () async {
    when(repository.refreshCatalog)
        .thenAnswer((_) async => const Success(SyncOutcome.updated));

    final result = await RefreshCatalogUseCase(repository)();

    expect(
      result,
      isA<Success<SyncOutcome>>().having(
        (s) => s.data,
        'data',
        SyncOutcome.updated,
      ),
    );
  });
}
