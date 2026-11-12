import 'dart:async';

import 'package:donuts/features/rewards/domain/usecases/watch_challenges_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_gifts_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_member_summary_use_case.dart';
import 'package:donuts/features/rewards/presentation/blocs/rewards_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Follows the member summary, challenges and gifts in the database, and
/// which card list is showing.
class RewardsCubit extends Cubit<RewardsState> {
  new({required this._member, required this._challenges, required this._gifts})
    : super(const RewardsState());

  final WatchMemberSummaryUseCase _member;
  final WatchChallengesUseCase _challenges;
  final WatchGiftsUseCase _gifts;
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

  /// Earn has no backend action; pressing it only stops its pulse.
  void acknowledgeEarn(String challengeId) => emit(
    state.copyWith(
      acknowledgedEarns: {...state.acknowledgedEarns, challengeId},
    ),
  );

  /// Drops the current streams and subscribes again from loading, keeping
  /// the selected tab.
  void retry() {
    unawaited(_cancel());
    emit(
      RewardsState(tab: state.tab, acknowledgedEarns: state.acknowledgedEarns),
    );
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
