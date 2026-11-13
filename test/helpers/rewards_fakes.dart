import 'dart:async';

import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/rewards/domain/repositories/rewards_repository.dart';
import 'package:donuts/features/rewards/domain/types/challenge_kind.dart';
import 'package:donuts/features/rewards/domain/usecases/claim_challenge_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_challenges_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_gifts_use_case.dart';
import 'package:donuts/features/rewards/domain/vo/challenge_vo.dart';
import 'package:donuts/features/rewards/domain/vo/gift_vo.dart';
import 'package:donuts/features/rewards/presentation/blocs/rewards_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchChallengesUseCase extends Mock implements WatchChallengesUseCase;

class MockWatchGiftsUseCase extends Mock implements WatchGiftsUseCase;

/// The seeded challenges: Coco 4/4, americano 9/12, strawberry 1/4.
const List<ChallengeVO> testChallenges = [
  ChallengeVO(
    id: 'c_coco_donuts',
    title: 'Eat 4 Coco donuts',
    kind: ChallengeKind.donutQuarters,
    progress: 4,
    target: 4,
    rewardPoints: 100,
  ),
  ChallengeVO(
    id: 'c_americano',
    title: 'Drink 12 cups americano',
    kind: ChallengeKind.coffeeArc,
    progress: 9,
    target: 12,
    rewardPoints: 200,
  ),
  ChallengeVO(
    id: 'c_strawberry_donuts',
    title: 'Eat 4 Strawberry donuts',
    kind: ChallengeKind.donutQuarters,
    progress: 1,
    target: 4,
    rewardPoints: 100,
  ),
];

/// The seeded gifts, cheapest first.
const List<GiftVO> testGifts = [
  GiftVO(id: 'g_classic_donut', title: 'Free classic donut', costPoints: 20000),
  GiftVO(id: 'g_iced_latte', title: 'Free iced latte', costPoints: 35000),
  GiftVO(id: 'g_box_of_six', title: 'Box of 6 donuts', costPoints: 90000),
];

/// A rewards repository that emits [challenges] and [gifts]. Earn marks a
/// complete challenge claimed and emits the list again, as the database
/// does.
class FakeRewardsRepository implements RewardsRepository {
  new({this.challenges = testChallenges, this.gifts = testGifts});

  final List<ChallengeVO> challenges;
  final List<GiftVO> gifts;
  final Set<String> _claimed = {};
  final Set<StreamController<List<ChallengeVO>>> _listeners = {};

  @override
  Stream<List<ChallengeVO>> watchChallenges() {
    late final StreamController<List<ChallengeVO>> controller;
    controller = StreamController(
      onListen: () {
        controller.add(_withClaims());
        _listeners.add(controller);
      },
      onCancel: () => _listeners.remove(controller),
    );
    return controller.stream;
  }

  List<ChallengeVO> _withClaims() => [
    for (final c in challenges) c.copyWith(claimed: _claimed.contains(c.id)),
  ];

  @override
  Stream<List<GiftVO>> watchGifts() => Stream.value(gifts);

  @override
  Future<Result<void>> claimChallenge(String challengeId) async {
    final challenge = challenges.where((c) => c.id == challengeId).firstOrNull;
    if (challenge != null &&
        challenge.isComplete &&
        _claimed.add(challengeId)) {
      for (final listener in [..._listeners]) {
        listener.add(_withClaims());
      }
    }
    return const Success(null);
  }
}

/// Fakes for the rewards screen's get_it dependencies, used by
/// `pumpRouterApp`. Register each one only if
/// `getIt.isRegistered<T>()` is false, so a test's own fakes win.
/// The member summary comes from `registerMemberFakes`, which must run
/// first.
void registerRewardsFakes(GetIt getIt) {
  if (!getIt.isRegistered<RewardsRepository>()) {
    getIt.registerSingleton<RewardsRepository>(FakeRewardsRepository());
  }
  if (!getIt.isRegistered<WatchChallengesUseCase>()) {
    getIt.registerSingleton(WatchChallengesUseCase(getIt()));
  }
  if (!getIt.isRegistered<WatchGiftsUseCase>()) {
    getIt.registerSingleton(WatchGiftsUseCase(getIt()));
  }
  if (!getIt.isRegistered<ClaimChallengeUseCase>()) {
    getIt.registerSingleton(ClaimChallengeUseCase(getIt()));
  }
  if (!getIt.isRegistered<RewardsCubit>()) {
    getIt.registerFactory(
      () => RewardsCubit(
        member: getIt(),
        challenges: getIt(),
        gifts: getIt(),
        claim: getIt(),
      ),
    );
  }
}
