import 'dart:async';

import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/rewards/domain/repositories/member_repository.dart';
import 'package:donuts/features/rewards/domain/repositories/rewards_repository.dart';
import 'package:donuts/features/rewards/domain/tier_progress.dart';
import 'package:donuts/features/rewards/domain/usecases/claim_challenge_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_challenges_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_gifts_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_member_summary_use_case.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/member_fakes.dart';
import '../../../../helpers/rewards_fakes.dart';

class MockMemberRepository extends Mock implements MemberRepository;

class MockRewardsRepository extends Mock implements RewardsRepository;

const String _cocoId = 'c_coco_donuts';

final Exception _dbError = Exception('database is locked');

void main() {
  late MockMemberRepository member;
  late MockRewardsRepository rewards;

  setUp(() {
    member = MockMemberRepository();
    rewards = MockRewardsRepository();
  });

  group('WatchMemberSummaryUseCase', () {
    // The seeded member after earning the Coco challenge's 100 points.
    final earned = testMemberSummary.copyWith(
      totalPoints: 680100,
      tierProgress: resolveTierProgress(680100, testTiers),
    );

    test('reads the summary stream from the repository once', () {
      when(member.watchSummary).thenAnswer((_) => const Stream.empty());

      WatchMemberSummaryUseCase(member)();

      verify(member.watchSummary).called(1);
      verifyNoMoreInteractions(member);
    });

    test('emits null while no member record is seeded', () {
      when(member.watchSummary).thenAnswer((_) => Stream.value(null));

      expect(
        WatchMemberSummaryUseCase(member)(),
        emitsInOrder([isNull, emitsDone]),
      );
    });

    test('emits each summary the repository emits, in order, then '
        'completes', () {
      when(member.watchSummary).thenAnswer(
        (_) => Stream<MemberSummary?>.fromIterable([
          null,
          testMemberSummary,
          earned,
        ]),
      );

      expect(
        WatchMemberSummaryUseCase(member)(),
        emitsInOrder([isNull, testMemberSummary, earned, emitsDone]),
      );
    });

    test('passes a repository error through and keeps emitting', () {
      when(member.watchSummary).thenAnswer(
        (_) => _withError<MemberSummary?>(testMemberSummary, _dbError, earned),
      );

      expect(
        WatchMemberSummaryUseCase(member)(),
        emitsInOrder([
          testMemberSummary,
          emitsError(same(_dbError)),
          earned,
          emitsDone,
        ]),
      );
    });
  });

  group('WatchChallengesUseCase', () {
    final afterClaim = [
      testChallenges.first.copyWith(claimed: true),
      ...testChallenges.skip(1),
    ];

    test('reads the challenges stream from the repository once', () {
      when(rewards.watchChallenges).thenAnswer((_) => const Stream.empty());

      WatchChallengesUseCase(rewards)();

      verify(rewards.watchChallenges).called(1);
      verifyNoMoreInteractions(rewards);
    });

    test('emits each list the repository emits, in order, then '
        'completes', () {
      when(rewards.watchChallenges).thenAnswer(
        (_) => Stream.fromIterable([testChallenges, afterClaim, const []]),
      );

      expect(
        WatchChallengesUseCase(rewards)(),
        emitsInOrder([testChallenges, afterClaim, isEmpty, emitsDone]),
      );
    });

    test('passes a repository error through and keeps emitting', () {
      when(rewards.watchChallenges)
          .thenAnswer((_) => _withError(testChallenges, _dbError, afterClaim));

      expect(
        WatchChallengesUseCase(rewards)(),
        emitsInOrder([
          testChallenges,
          emitsError(same(_dbError)),
          afterClaim,
          emitsDone,
        ]),
      );
    });
  });

  group('WatchGiftsUseCase', () {
    test('reads the gifts stream from the repository once', () {
      when(rewards.watchGifts).thenAnswer((_) => const Stream.empty());

      WatchGiftsUseCase(rewards)();

      verify(rewards.watchGifts).called(1);
      verifyNoMoreInteractions(rewards);
    });

    test('emits each list the repository emits, in order, then '
        'completes', () {
      when(rewards.watchGifts).thenAnswer(
        (_) => Stream.fromIterable([testGifts, const [], testGifts.sublist(1)]),
      );

      expect(
        WatchGiftsUseCase(rewards)(),
        emitsInOrder([testGifts, isEmpty, testGifts.sublist(1), emitsDone]),
      );
    });

    test('passes a repository error through and keeps emitting', () {
      when(rewards.watchGifts)
          .thenAnswer((_) => _withError(testGifts, _dbError, const []));

      expect(
        WatchGiftsUseCase(rewards)(),
        emitsInOrder([
          testGifts,
          emitsError(same(_dbError)),
          isEmpty,
          emitsDone,
        ]),
      );
    });
  });

  group('ClaimChallengeUseCase', () {
    test('claims the given challenge through the repository once', () async {
      when(() => rewards.claimChallenge(_cocoId))
          .thenAnswer((_) async => const Success(null));

      final result = await ClaimChallengeUseCase(rewards)(_cocoId);

      expect(result, isA<Success<void>>());
      verify(() => rewards.claimChallenge(_cocoId)).called(1);
      verifyNoMoreInteractions(rewards);
    });

    test('returns the repository failure when the claim cannot be '
        'stored', () async {
      final failure = DatabaseFailure(error: _dbError);
      when(() => rewards.claimChallenge(_cocoId))
          .thenAnswer((_) async => Failure(failure));

      final result = await ClaimChallengeUseCase(rewards)(_cocoId);

      expect(_failureOf(result), same(failure));
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

AppFailure _failureOf<T>(Result<T> result) => switch (result) {
  Failure(:final failure) => failure,
  Success(:final data) => throw TestFailure('Expected a failure, got $data'),
};
