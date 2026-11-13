import 'dart:async';

import 'package:donuts/features/home/domain/repositories/home_repository.dart';
import 'package:donuts/features/home/domain/usecases/watch_banners_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_home_sections_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_section_products_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_shops_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/home_fixtures.dart';

class MockHomeRepository extends Mock implements HomeRepository;

final Exception _dbError = Exception('database is locked');

void main() {
  late MockHomeRepository home;

  setUp(() => home = MockHomeRepository());

  group('WatchBannersUseCase', () {
    test('reads the banners stream from the repository once', () {
      when(home.watchBanners).thenAnswer((_) => const Stream.empty());

      WatchBannersUseCase(home)();

      verify(home.watchBanners).called(1);
      verifyNoMoreInteractions(home);
    });

    test('emits each list the repository emits, in order, then '
        'completes', () {
      when(home.watchBanners).thenAnswer(
        (_) => Stream.fromIterable([
          testBanners,
          const [],
          [testBanners.last],
        ]),
      );

      expect(
        WatchBannersUseCase(home)(),
        emitsInOrder([
          testBanners,
          isEmpty,
          [testBanners.last],
          emitsDone,
        ]),
      );
    });

    test('passes a repository error through and keeps emitting', () {
      when(home.watchBanners)
          .thenAnswer((_) => _withError(testBanners, _dbError, const []));

      expect(
        WatchBannersUseCase(home)(),
        emitsInOrder([
          testBanners,
          emitsError(same(_dbError)),
          isEmpty,
          emitsDone,
        ]),
      );
    });
  });

  group('WatchHomeSectionsUseCase', () {
    test('reads the sections stream from the repository once', () {
      when(home.watchSections).thenAnswer((_) => const Stream.empty());

      WatchHomeSectionsUseCase(home)();

      verify(home.watchSections).called(1);
      verifyNoMoreInteractions(home);
    });

    test('emits each list the repository emits, in order, then '
        'completes', () {
      when(home.watchSections).thenAnswer(
        (_) => Stream.fromIterable([
          testHomeSections,
          const [],
          testHomeSections.reversed.toList(),
        ]),
      );

      expect(
        WatchHomeSectionsUseCase(home)(),
        emitsInOrder([
          testHomeSections,
          isEmpty,
          testHomeSections.reversed.toList(),
          emitsDone,
        ]),
      );
    });

    test('passes a repository error through and keeps emitting', () {
      when(home.watchSections)
          .thenAnswer((_) => _withError(testHomeSections, _dbError, const []));

      expect(
        WatchHomeSectionsUseCase(home)(),
        emitsInOrder([
          testHomeSections,
          emitsError(same(_dbError)),
          isEmpty,
          emitsDone,
        ]),
      );
    });
  });

  group('WatchSectionProductsUseCase', () {
    final seasonal = testSectionProducts['seasonal']!;
    final popular = testSectionProducts['popular']!;

    test('asks the repository for the products of the given row only', () {
      when(() => home.watchSectionProducts('seasonal'))
          .thenAnswer((_) => Stream.value(seasonal));
      when(() => home.watchSectionProducts('popular'))
          .thenAnswer((_) => Stream.value(popular));

      expect(
        WatchSectionProductsUseCase(home)('seasonal'),
        emitsInOrder([seasonal, emitsDone]),
      );
      verify(() => home.watchSectionProducts('seasonal')).called(1);
      verifyNever(() => home.watchSectionProducts('popular'));
    });

    test('emits each list the repository emits, in order, then '
        'completes', () {
      when(() => home.watchSectionProducts('popular')).thenAnswer(
        (_) => Stream.fromIterable([popular, const [], popular.sublist(1)]),
      );

      expect(
        WatchSectionProductsUseCase(home)('popular'),
        emitsInOrder([popular, isEmpty, popular.sublist(1), emitsDone]),
      );
    });

    test('passes a repository error through and keeps emitting', () {
      when(() => home.watchSectionProducts('popular'))
          .thenAnswer((_) => _withError(popular, _dbError, const []));

      expect(
        WatchSectionProductsUseCase(home)('popular'),
        emitsInOrder([popular, emitsError(same(_dbError)), isEmpty, emitsDone]),
      );
    });
  });

  group('WatchShopsUseCase', () {
    test('reads the shops stream from the repository once', () {
      when(home.watchShops).thenAnswer((_) => const Stream.empty());

      WatchShopsUseCase(home)();

      verify(home.watchShops).called(1);
      verifyNoMoreInteractions(home);
    });

    test('emits each list the repository emits, in order, then '
        'completes', () {
      when(home.watchShops).thenAnswer(
        (_) => Stream.fromIterable([
          testShops,
          const [],
          testShops.take(2).toList(),
        ]),
      );

      expect(
        WatchShopsUseCase(home)(),
        emitsInOrder([
          testShops,
          isEmpty,
          testShops.take(2).toList(),
          emitsDone,
        ]),
      );
    });

    test('passes a repository error through and keeps emitting', () {
      when(home.watchShops)
          .thenAnswer((_) => _withError(testShops, _dbError, const []));

      expect(
        WatchShopsUseCase(home)(),
        emitsInOrder([
          testShops,
          emitsError(same(_dbError)),
          isEmpty,
          emitsDone,
        ]),
      );
    });
  });
}

/// Emits [before], then [error], then [after], then closes.
Stream<T> _withError<T>(T before, Object error, T after) {
  final controller = StreamController<T>()
    ..add(before)
    ..addError(error)
    ..add(after);
  unawaited(controller.close());
  return controller.stream;
}
