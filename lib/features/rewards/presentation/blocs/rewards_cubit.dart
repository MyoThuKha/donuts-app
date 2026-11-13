import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/state/section_state.dart';
import 'package:donuts/core/state/section_watcher.dart';
import 'package:donuts/features/rewards/domain/usecases/claim_challenge_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_challenges_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_gifts_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_member_summary_use_case.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';
import 'package:donuts/features/rewards/presentation/blocs/rewards_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Follows the member summary, challenges and gifts, each into its own
/// [SectionState], and which card list is showing. Earn stores a
/// challenge's points in the local database.
class RewardsCubit extends Cubit<RewardsState>
    with SectionWatcher<RewardsPart, RewardsState> {
  new({
    required this._member,
    required this._challenges,
    required this._gifts,
    required this._claim,
  }) : super(const RewardsState());

  final WatchMemberSummaryUseCase _member;
  final WatchChallengesUseCase _challenges;
  final WatchGiftsUseCase _gifts;
  final ClaimChallengeUseCase _claim;

  /// Subscribes to every part.
  void start() => RewardsPart.values.forEach(retry);

  /// Shows [part] as loading again and subscribes to it afresh.
  void retry(RewardsPart part) => switch (part) {
    RewardsPart.member => watchSection(
      part,
      _member().map(_memberState),
      (section) => state.copyWith(member: section),
    ),
    RewardsPart.challenges => watchSection(
      part,
      _challenges().map(listSection),
      (section) => state.copyWith(challenges: section),
    ),
    RewardsPart.gifts => watchSection(
      part,
      _gifts().map(listSection),
      (section) => state.copyWith(gifts: section),
    ),
  };

  void selectTab(RewardsTab tab) => emit(state.copyWith(tab: tab));

  /// Adds a completed challenge's points to the total. The challenge then
  /// arrives claimed through the challenges stream.
  Future<void> earn(String challengeId) async {
    if (await _claim(challengeId) case Failure(:final failure)) {
      addError(failure, failure.stackTrace ?? StackTrace.current);
    }
  }

  static SectionState<MemberSummary> _memberState(MemberSummary? summary) =>
      summary == null ? const SectionEmpty() : SectionReady(summary);
}
