import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/sync/domain/catalog_sync_repository.dart';
import 'package:donuts/core/sync/domain/sync_outcome.dart';
import 'package:donuts/core/sync/domain/usecases/refresh_catalog_use_case.dart';
import 'package:donuts/core/sync/domain/usecases/seed_local_data_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCatalogSyncRepository extends Mock implements CatalogSyncRepository;

void main() {
  late MockCatalogSyncRepository sync;

  setUp(() => sync = MockCatalogSyncRepository());

  group('RefreshCatalogUseCase', () {
    test('refreshes through the repository once', () async {
      when(sync.refreshCatalog)
          .thenAnswer((_) async => const Success(SyncOutcome.updated));

      await RefreshCatalogUseCase(sync)();

      verify(sync.refreshCatalog).called(1);
      verifyNoMoreInteractions(sync);
    });

    test('returns updated when the remote catalog was newer', () async {
      when(sync.refreshCatalog)
          .thenAnswer((_) async => const Success(SyncOutcome.updated));

      final result = await RefreshCatalogUseCase(sync)();

      expect(_dataOf(result), SyncOutcome.updated);
    });

    test('returns up to date when the stored catalog was current', () async {
      when(sync.refreshCatalog)
          .thenAnswer((_) async => const Success(SyncOutcome.upToDate));

      final result = await RefreshCatalogUseCase(sync)();

      expect(_dataOf(result), SyncOutcome.upToDate);
    });

    test('returns the repository failure when the device is offline', () async {
      final failure = NetworkFailure(error: Exception('no route to host'));
      when(sync.refreshCatalog).thenAnswer((_) async => Failure(failure));

      final result = await RefreshCatalogUseCase(sync)();

      expect(_failureOf(result), same(failure));
    });

    test('returns the repository failure when the request times out', () async {
      when(sync.refreshCatalog)
          .thenAnswer((_) async => const Failure(TimeoutFailure()));

      final result = await RefreshCatalogUseCase(sync)();

      expect(_failureOf(result), isA<TimeoutFailure>());
    });

    test('returns the server failure with its status code', () async {
      when(
        sync.refreshCatalog,
      ).thenAnswer((_) async => const Failure(ServerFailure(statusCode: 503)));

      final result = await RefreshCatalogUseCase(sync)();

      expect(
        _failureOf(result),
        isA<ServerFailure>().having((f) => f.statusCode, 'statusCode', 503),
      );
    });
  });

  group('SeedLocalDataUseCase', () {
    test('seeds through the repository once', () async {
      when(sync.seedIfNeeded).thenAnswer((_) async => const Success(null));

      final result = await SeedLocalDataUseCase(sync)();

      expect(result, isA<Success<void>>());
      verify(sync.seedIfNeeded).called(1);
      verifyNoMoreInteractions(sync);
    });

    test('returns the repository failure when the seed cannot be '
        'written', () async {
      final failure = DatabaseFailure(error: Exception('disk full'));
      when(sync.seedIfNeeded).thenAnswer((_) async => Failure(failure));

      final result = await SeedLocalDataUseCase(sync)();

      expect(_failureOf(result), same(failure));
    });

    test('returns the repository failure when the bundled seed cannot be '
        'parsed', () async {
      when(sync.seedIfNeeded)
          .thenAnswer((_) async => const Failure(ParsingFailure()));

      final result = await SeedLocalDataUseCase(sync)();

      expect(_failureOf(result), isA<ParsingFailure>());
    });
  });
}

T _dataOf<T>(Result<T> result) => switch (result) {
  Success(:final data) => data,
  Failure(:final failure) => throw TestFailure('Expected data, got $failure'),
};

AppFailure _failureOf<T>(Result<T> result) => switch (result) {
  Failure(:final failure) => failure,
  Success(:final data) => throw TestFailure('Expected a failure, got $data'),
};
