import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/sync/presentation/seed_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/fakes.dart';

void main() {
  late MockSeedLocalDataUseCase seed;

  setUp(() => seed = MockSeedLocalDataUseCase());

  blocTest<SeedCubit, SeedStatus>(
    'a successful seed ends done',
    setUp: () => when(seed.call).thenAnswer((_) async => const Success(null)),
    build: () => SeedCubit(seed),
    act: (cubit) => cubit.seed(),
    expect: () => [SeedStatus.seeding, SeedStatus.done],
  );

  blocTest<SeedCubit, SeedStatus>(
    'a failed seed ends failed and reports the failure as an error',
    setUp: () =>
        when(seed.call)
            .thenAnswer((_) async => const Failure(DatabaseFailure())),
    build: () => SeedCubit(seed),
    act: (cubit) => cubit.seed(),
    expect: () => [SeedStatus.seeding, SeedStatus.failed],
    errors: () => [isA<DatabaseFailure>()],
  );

  blocTest<SeedCubit, SeedStatus>(
    'a retry after a failure can still succeed',
    setUp: () {
      var calls = 0;
      when(seed.call).thenAnswer(
        (_) async => calls++ == 0
            ? const Failure(ParsingFailure())
            : const Success(null),
      );
    },
    build: () => SeedCubit(seed),
    act: (cubit) async {
      await cubit.seed();
      await cubit.seed();
    },
    expect: () => [
      SeedStatus.seeding,
      SeedStatus.failed,
      SeedStatus.seeding,
      SeedStatus.done,
    ],
    errors: () => [isA<ParsingFailure>()],
  );

  test('a second tap while seeding starts no second seed', () async {
    final pending = Completer<Result<void>>();
    when(seed.call).thenAnswer((_) => pending.future);
    final cubit = SeedCubit(seed);
    addTearDown(cubit.close);

    unawaited(cubit.seed());
    await cubit.seed();
    pending.complete(const Success(null));
    await pumpEventQueue();

    verify(seed.call).called(1);
    expect(cubit.state, SeedStatus.done);
  });
}
