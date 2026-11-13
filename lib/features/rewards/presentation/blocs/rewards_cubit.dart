import 'dart:async';

import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/rewards/domain/usecases/claim_challenge_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/clear_reward_claims_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_challenges_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_gifts_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_member_summary_use_case.dart';
import 'package:donuts/features/rewards/presentation/blocs/rewards_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Follows the member summary, challenges and gifts, and which card list
/// is showing. Earn claims a challenge's points for this run of the app.
class RewardsCubit extends Cubit<RewardsState> {
  new({
    required this._member,
    required this._challenges,
    required this._gifts,
    required this._claim,
    required this._clearClaims,
  }) : super(const RewardsState());

  final WatchMemberSummaryUseCase _member;
  final WatchChallengesUseCase _challenges;
  final WatchGiftsUseCase _gifts;
  final ClaimChallengeUseCase _claim;
  final ClearRewardClaimsUseCase _clearClaims;
  final List<StreamSubscription<Object?>> _subscriptions = [];

  /// Ready once the member summary arrives. Any stream error fails the
  /// screen until [retry].
  void start() {
    _subscriptions.addAll([
      _member().listen((m) => emit(state.withMember(m)), onError: _fail),
      _challenges().listen(
        (list) => emit(state.copyWith(challenges: list)),
        onError: _fail,
      ),
      _gifts().listen(
        (list) => emit(state.copyWith(gifts: list)),
        onError: _fail,
      ),
    ]);
  }

  void selectTab(RewardsTab tab) => emit(state.copyWith(tab: tab));

  /// Adds a completed challenge's points to the total. The challenge then
  /// arrives claimed through the challenges stream.
  Future<void> earn(String challengeId) async {
    if (await _claim(challengeId) case Failure(:final failure)) {
      addError(failure, failure.stackTrace ?? StackTrace.current);
    }
  }

  /// Undoes every Earn, so the points and challenges read as stored.
  void resetClaims() => _clearClaims();

  /// Drops the current streams and subscribes again from loading, keeping
  /// the selected tab.
  void retry() {
    unawaited(_cancel());
    emit(RewardsState(tab: state.tab));
    start();
  }

  void _fail(Object error, StackTrace stackTrace) {
    addError(error, stackTrace);
    unawaited(_cancel());
    emit(state.copyWith(status: RewardsStatus.failed));
  }

  Future<void> _cancel() async {
    final current = [..._subscriptions];
    _subscriptions.clear();
    await Future.wait([for (final s in current) s.cancel()]);
  }

  @override
  Future<void> close() async {
    await _cancel();
    await super.close();
  }
}
