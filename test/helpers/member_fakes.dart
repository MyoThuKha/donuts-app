import 'package:donuts/features/rewards/domain/repositories/member_repository.dart';
import 'package:donuts/features/rewards/domain/tier_progress.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_member_summary_use_case.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';
import 'package:donuts/features/rewards/domain/vo/tier_vo.dart';
import 'package:get_it/get_it.dart';

/// The seeded tiers: Silver, Gold and Platinum.
const List<TierVO> testTiers = [
  TierVO(id: 'silver', name: 'Silver', minPoints: 678500, sortOrder: 0),
  TierVO(id: 'gold', name: 'Gold', minPoints: 680500, sortOrder: 1),
  TierVO(id: 'platinum', name: 'Platinum', minPoints: 1000000, sortOrder: 2),
];

/// The seeded member: 680,000 points, Silver, 500 points to Gold.
final MemberSummary testMemberSummary = MemberSummary(
  totalPoints: 680000,
  avatarUrl: 'https://example.com/avatar.webp',
  notificationCount: 2,
  rewardsCount: 3,
  tiers: testTiers,
  tierProgress: resolveTierProgress(680000, testTiers),
);

/// A member repository that emits [summary] once.
class FakeMemberRepository implements MemberRepository {
  new([this.summary]);

  final MemberSummary? summary;

  @override
  Stream<MemberSummary?> watchSummary() =>
      Stream.value(summary ?? testMemberSummary);
}

/// Registers the shared member summary unless a test registered its own.
/// Home and Rewards fakes must not register these two types.
void registerMemberFakes(GetIt getIt) {
  if (!getIt.isRegistered<MemberRepository>()) {
    getIt.registerSingleton<MemberRepository>(FakeMemberRepository());
  }
  if (!getIt.isRegistered<WatchMemberSummaryUseCase>()) {
    getIt.registerSingleton(WatchMemberSummaryUseCase(getIt()));
  }
}
