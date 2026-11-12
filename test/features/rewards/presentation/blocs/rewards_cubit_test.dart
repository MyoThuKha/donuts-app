import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_member_summary_use_case.dart';
import 'package:donuts/features/rewards/presentation/blocs/rewards_cubit.dart';
import 'package:donuts/features/rewards/presentation/blocs/rewards_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/member_fakes.dart';
import '../../../../helpers/rewards_fakes.dart';

class _MockWatchMember extends Mock implements WatchMemberSummaryUseCase;

void main() {
  late _MockWatchMember member;
  late MockWatchChallengesUseCase challenges;
  late MockWatchGiftsUseCase gifts;

  RewardsCubit build() =>
      RewardsCubit(member: member, challenges: challenges, gifts: gifts);

  setUp(() {
    member = _MockWatchMember();
    challenges = MockWatchChallengesUseCase();
    gifts = MockWatchGiftsUseCase();
    when(member.call).thenAnswer((_) => Stream.value(testMemberSummary));
    when(challenges.call).thenAnswer((_) => Stream.value(testChallenges));
    when(gifts.call).thenAnswer((_) => Stream.value(testGifts));
  });

  test('starts loading on the challenges tab', () {
    final cubit = build();
    addTearDown(cubit.close);

    expect(cubit.state.status, RewardsStatus.loading);
    expect(cubit.state.tab, RewardsTab.challenges);
  });

  blocTest<RewardsCubit, RewardsState>(
    'becomes ready with the member, challenges and gifts',
    build: build,
    act: (cubit) => cubit.start(),
    verify: (cubit) {
      expect(cubit.state.status, RewardsStatus.ready);
      expect(cubit.state.member, testMemberSummary);
      expect(cubit.state.challenges, testChallenges);
      expect(cubit.state.gifts, testGifts);
    },
  );

  blocTest<RewardsCubit, RewardsState>(
    'a null member is empty',
    setUp: () => when(member.call).thenAnswer((_) => Stream.value(null)),
    build: build,
    act: (cubit) => cubit.start(),
    verify: (cubit) => expect(cubit.state.status, RewardsStatus.empty),
  );

  blocTest<RewardsCubit, RewardsState>(
    'a stream error is failed',
    setUp: () =>
        when(challenges.call)
            .thenAnswer((_) => Stream.error(StateError('database closed'))),
    build: build,
    act: (cubit) => cubit.start(),
    verify: (cubit) => expect(cubit.state.status, RewardsStatus.failed),
  );

  blocTest<RewardsCubit, RewardsState>(
    'selectTab switches to gifts',
    build: build,
    act: (cubit) => cubit.selectTab(RewardsTab.gifts),
    expect: () => [
      isA<RewardsState>().having((s) => s.tab, 'tab', RewardsTab.gifts),
    ],
  );

  blocTest<RewardsCubit, RewardsState>(
    'acknowledgeEarn remembers the challenge whose Earn was pressed',
    build: build,
    act: (cubit) => cubit.acknowledgeEarn('c_coco_donuts'),
    verify: (cubit) => expect(cubit.state.acknowledgedEarns, {'c_coco_donuts'}),
  );

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
      expect(cubit.state.status, RewardsStatus.failed);
      cubit.retry();
    },
    verify: (cubit) {
      expect(cubit.state.status, RewardsStatus.ready);
      expect(cubit.state.member, testMemberSummary);
      verify(member.call).called(2);
    },
  );

  test('retry goes back to loading first', () async {
    when(member.call).thenAnswer((_) => const Stream.empty());
    final cubit = build()
      ..start()
      ..selectTab(RewardsTab.gifts);
    addTearDown(cubit.close);

    cubit.retry();

    expect(cubit.state.status, RewardsStatus.loading);
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
