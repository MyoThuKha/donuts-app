import 'package:donuts/core/state/section_state.dart';
import 'package:donuts/features/rewards/domain/vo/challenge_vo.dart';
import 'package:donuts/features/rewards/domain/vo/gift_vo.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';
import 'package:equatable/equatable.dart';

/// The three parts of Rewards that load on their own.
enum RewardsPart { member, challenges, gifts }

/// The two card lists under the points ring.
enum RewardsTab { challenges, gifts }

final class RewardsState extends Equatable {
  const new({
    this.member = const SectionLoading(),
    this.challenges = const SectionLoading(),
    this.gifts = const SectionLoading(),
    this.tab = RewardsTab.challenges,
  });

  /// Drives the header badge, the tier ladder and the points ring.
  final SectionState<MemberSummary> member;
  final SectionState<List<ChallengeVO>> challenges;
  final SectionState<List<GiftVO>> gifts;
  final RewardsTab tab;

  /// The member once loaded, else null.
  MemberSummary? get memberOrNull => switch (member) {
    SectionReady(:final data) => data,
    _ => null,
  };

  RewardsState copyWith({
    SectionState<MemberSummary>? member,
    SectionState<List<ChallengeVO>>? challenges,
    SectionState<List<GiftVO>>? gifts,
    RewardsTab? tab,
  }) => RewardsState(
    member: member ?? this.member,
    challenges: challenges ?? this.challenges,
    gifts: gifts ?? this.gifts,
    tab: tab ?? this.tab,
  );

  @override
  List<Object?> get props => [member, challenges, gifts, tab];
}
