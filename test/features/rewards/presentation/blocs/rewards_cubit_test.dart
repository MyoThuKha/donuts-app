import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:donuts/core/state/section_state.dart';
import 'package:donuts/features/rewards/domain/usecases/claim_challenge_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/clear_reward_claims_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_challenges_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_member_summary_use_case.dart';
import 'package:donuts/features/rewards/domain/vo/challenge_vo.dart';
import 'package:donuts/features/rewards/domain/vo/gift_vo.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';
import 'package:donuts/features/rewards/presentation/blocs/rewards_cubit.dart';
import 'package:donuts/features/rewards/presentation/blocs/rewards_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/member_fakes.dart';
import '../../../../helpers/rewards_fakes.dart';

class _MockWatchMember extends Mock implements WatchMemberSummaryUseCase;

List<ChallengeVO> _challenges(RewardsState state) => switch (state.challenges) {
  SectionReady(:final data) => data,
  _ => throw StateError('challenges not ready'),
};

void main() {
  late _MockWatchMember member;
  late MockWatchChallengesUseCase challenges;
  late MockWatchGiftsUseCase gifts;

  late FakeRewardsRepository repository;

  RewardsCubit build() => RewardsCubit(
    member: member,
    challenges: challenges,
    gifts: gifts,
    claim: ClaimChallengeUseCase(repository),
    clearClaims: ClearRewardClaimsUseCase(repository),
  );

  setUp(() {
    member = _MockWatchMember();
    challenges = MockWatchChallengesUseCase();
    gifts = MockWatchGiftsUseCase();
    repository = FakeRewardsRepository();
    when(member.call).thenAnswer((_) => Stream.value(testMemberSummary));
    when(challenges.call).thenAnswer((_) => Stream.value(testChallenges));
    when(gifts.call).thenAnswer((_) => Stream.value(testGifts));
  });

  test('starts loading on the challenges tab', () {
    final cubit = build();
    addTearDown(cubit.close);

    expect(cubit.state, const RewardsState());
    expect(cubit.state.member, isA<SectionLoading<MemberSummary>>());
    expect(cubit.state.tab, RewardsTab.challenges);
  });

  blocTest<RewardsCubit, RewardsState>(
    'becomes ready with the member, challenges and gifts',
    build: build,
    act: (cubit) => cubit.start(),
    verify: (cubit) => expect(
      cubit.state,
      RewardsState(
        member: SectionReady(testMemberSummary),
        challenges: const SectionReady(testChallenges),
        gifts: const SectionReady(testGifts),
      ),
    ),
  );

  test('the lists stay loading until their own streams emit', () async {
    final challengeStream = StreamController<List<ChallengeVO>>();
    addTearDown(challengeStream.close);
    when(challenges.call).thenAnswer((_) => challengeStream.stream);
    final cubit = build()..start();
    addTearDown(cubit.close);
    await pumpEventQueue();

    expect(cubit.state.member, SectionReady(testMemberSummary));
    expect(cubit.state.challenges, isA<SectionLoading<List<ChallengeVO>>>());

    challengeStream.add(const []);
    await pumpEventQueue();

    expect(cubit.state.challenges, isA<SectionEmpty<List<ChallengeVO>>>());
  });

  blocTest<RewardsCubit, RewardsState>(
    'a null member is empty',
    setUp: () => when(member.call).thenAnswer((_) => Stream.value(null)),
    build: build,
    act: (cubit) => cubit.start(),
    verify: (cubit) =>
        expect(cubit.state.member, isA<SectionEmpty<MemberSummary>>()),
  );

  blocTest<RewardsCubit, RewardsState>(
    'a challenges error fails only the challenges',
    setUp: () =>
        when(challenges.call)
            .thenAnswer((_) => Stream.error(StateError('database closed'))),
    build: build,
    act: (cubit) => cubit.start(),
    errors: () => [isA<StateError>()],
    verify: (cubit) => expect(
      cubit.state,
      RewardsState(
        member: SectionReady(testMemberSummary),
        challenges: const SectionFailed(),
        gifts: const SectionReady(testGifts),
      ),
    ),
  );

  blocTest<RewardsCubit, RewardsState>(
    'selectTab switches to gifts',
    build: build,
    act: (cubit) => cubit.selectTab(RewardsTab.gifts),
    expect: () => [
      isA<RewardsState>().having((s) => s.tab, 'tab', RewardsTab.gifts),
    ],
  );

  test('earn claims a complete challenge and resetClaims undoes it', () async {
    final cubit = RewardsCubit(
      member: member,
      challenges: WatchChallengesUseCase(repository),
      gifts: gifts,
      claim: ClaimChallengeUseCase(repository),
      clearClaims: ClearRewardClaimsUseCase(repository),
    )..start();
    addTearDown(cubit.close);
    await pumpEventQueue();

    bool claimed(String id) =>
        _challenges(cubit.state).firstWhere((c) => c.id == id).claimed;

    await cubit.earn('c_coco_donuts');
    await pumpEventQueue();
    expect(claimed('c_coco_donuts'), isTrue);

    cubit.resetClaims();
    await pumpEventQueue();
    expect(claimed('c_coco_donuts'), isFalse);
  });

  test('earn leaves an incomplete challenge unclaimed', () async {
    final cubit = RewardsCubit(
      member: member,
      challenges: WatchChallengesUseCase(repository),
      gifts: gifts,
      claim: ClaimChallengeUseCase(repository),
      clearClaims: ClearRewardClaimsUseCase(repository),
    )..start();
    addTearDown(cubit.close);
    await pumpEventQueue();

    await cubit.earn('c_americano');
    await pumpEventQueue();

    expect(
      _challenges(cubit.state).firstWhere((c) => c.id == 'c_americano').claimed,
      isFalse,
    );
  });

  blocTest<RewardsCubit, RewardsState>(
    'retry after a failure resubscribes and recovers',
    setUp: () {
      var calls = 0;
      when(member.call).thenAnswer(
        (_) => calls++ == 0
            ? Stream.error(StateError('database closed'))
            : Stream.value(testMemberSummary),
      );
    },
    build: build,
    act: (cubit) async {
      cubit.start();
      await pumpEventQueue();
      expect(cubit.state.member, isA<SectionFailed<MemberSummary>>());
      cubit.retry(RewardsPart.member);
    },
    errors: () => [isA<StateError>()],
    verify: (cubit) {
      expect(cubit.state.member, SectionReady(testMemberSummary));
      verify(member.call).called(2);
      verify(challenges.call).called(1);
    },
  );

  test('retry shows its part loading first and keeps the tab', () async {
    final cubit = build()..start();
    addTearDown(cubit.close);
    await pumpEventQueue();
    cubit.selectTab(RewardsTab.gifts);
    when(gifts.call).thenAnswer((_) => const Stream.empty());

    cubit.retry(RewardsPart.gifts);

    expect(cubit.state.gifts, isA<SectionLoading<List<GiftVO>>>());
    expect(cubit.state.member, SectionReady(testMemberSummary));
    expect(cubit.state.tab, RewardsTab.gifts);
  });

  test('close cancels the subscriptions', () async {
    final cancelled = <String>[];
    StreamController<T> controller<T>(String name) =>
        StreamController<T>(onCancel: () => cancelled.add(name));
    final memberStream = controller<Never>('member');
    final challengeStream = controller<Never>('challenges');
    final giftStream = controller<Never>('gifts');
    when(member.call).thenAnswer((_) => memberStream.stream);
    when(challenges.call).thenAnswer((_) => challengeStream.stream);
    when(gifts.call).thenAnswer((_) => giftStream.stream);
    final cubit = build()..start();
    await pumpEventQueue();

    await cubit.close();

    expect(cancelled, unorderedEquals(['member', 'challenges', 'gifts']));
  });
}
