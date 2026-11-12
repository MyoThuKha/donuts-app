import 'package:donuts/features/rewards/domain/types/challenge_kind.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_challenges_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_gifts_use_case.dart';
import 'package:donuts/features/rewards/domain/vo/challenge_vo.dart';
import 'package:donuts/features/rewards/domain/vo/gift_vo.dart';
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

/// Fakes for the rewards screen's get_it dependencies, used by
/// `pumpRouterApp`. Register each one only if
/// `getIt.isRegistered<T>()` is false, so a test's own fakes win.
/// The member summary comes from `registerMemberFakes`.
void registerRewardsFakes(GetIt getIt) {}
