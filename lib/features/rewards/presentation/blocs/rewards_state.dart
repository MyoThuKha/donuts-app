import 'package:donuts/features/rewards/domain/vo/challenge_vo.dart';
import 'package:donuts/features/rewards/domain/vo/gift_vo.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';
import 'package:equatable/equatable.dart';

enum RewardsStatus { loading, ready, empty, failed }

/// The two card lists under the points ring.
enum RewardsTab { challenges, gifts }

final class RewardsState extends Equatable {
  const new({
    this.status = RewardsStatus.loading,
    this.member,
    this.challenges = const [],
    this.gifts = const [],
    this.tab = RewardsTab.challenges,
    this.acknowledgedEarns = const {},
  });

  final RewardsStatus status;

  /// Present once the status is [RewardsStatus.ready].
  final MemberSummary? member;
  final List<ChallengeVO> challenges;
  final List<GiftVO> gifts;
  final RewardsTab tab;

  /// Challenges whose Earn button the user has pressed, so it stops
  /// pulsing for the rest of the session.
  final Set<String> acknowledgedEarns;

  RewardsState copyWith({
    RewardsStatus? status,
    List<ChallengeVO>? challenges,
    List<GiftVO>? gifts,
    RewardsTab? tab,
    Set<String>? acknowledgedEarns,
  }) => RewardsState(
    status: status ?? this.status,
    member: member,
    challenges: challenges ?? this.challenges,
    gifts: gifts ?? this.gifts,
    tab: tab ?? this.tab,
    acknowledgedEarns: acknowledgedEarns ?? this.acknowledgedEarns,
  );

  /// The same lists and tab with a new [member]: ready when there is one,
  /// empty when the member data hasn't been seeded.
  RewardsState withMember(MemberSummary? member) => RewardsState(
    status: member == null ? RewardsStatus.empty : RewardsStatus.ready,
    member: member,
    challenges: challenges,
    gifts: gifts,
    tab: tab,
    acknowledgedEarns: acknowledgedEarns,
  );

  @override
  List<Object?> get props => [
    status,
    member,
    challenges,
    gifts,
    tab,
    acknowledgedEarns,
  ];
}
