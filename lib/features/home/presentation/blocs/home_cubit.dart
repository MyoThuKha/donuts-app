import 'dart:async';

import 'package:donuts/features/home/domain/usecases/watch_banners_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_home_sections_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_shops_use_case.dart';
import 'package:donuts/features/home/presentation/blocs/home_state.dart';
import 'package:donuts/features/home/presentation/blocs/section_state.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_member_summary_use_case.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Follows the four Home streams, each into its own [SectionState].
class HomeCubit extends Cubit<HomeState> {
  new({
    required this._member,
    required this._banners,
    required this._sections,
    required this._shops,
  }) : super(const HomeState());

  final WatchMemberSummaryUseCase _member;
  final WatchBannersUseCase _banners;
  final WatchHomeSectionsUseCase _sections;
  final WatchShopsUseCase _shops;
  final Map<HomeSectionId, StreamSubscription<Object?>> _subscriptions = {};

  /// Subscribes to every section.
  void start() => HomeSectionId.values.forEach(_subscribe);

  /// Shows [id] as loading again and subscribes to it afresh.
  void retry(HomeSectionId id) => _subscribe(id);

  void _subscribe(HomeSectionId id) {
    unawaited(_subscriptions.remove(id)?.cancel());
    _subscriptions[id] = switch (id) {
      HomeSectionId.member => _watch(
        _member().map(_memberState),
        (section) => state.copyWith(member: section),
      ),
      HomeSectionId.banners => _watch(
        _banners().map(_listState),
        (section) => state.copyWith(banners: section),
      ),
      HomeSectionId.sections => _watch(
        _sections().map(_listState),
        (section) => state.copyWith(sections: section),
      ),
      HomeSectionId.shops => _watch(
        _shops().map(_listState),
        (section) => state.copyWith(shops: section),
      ),
    };
  }

  /// Sets the section to loading, then follows [source] into it through
  /// [put]. An error marks only this section as failed.
  StreamSubscription<SectionState<T>> _watch<T>(
    Stream<SectionState<T>> source,
    HomeState Function(SectionState<T> section) put,
  ) {
    _emitIfOpen(put(SectionLoading<T>()));
    return source.listen(
      (section) => _emitIfOpen(put(section)),
      onError: (Object _, StackTrace _) => _emitIfOpen(put(SectionFailed<T>())),
    );
  }

  static SectionState<MemberSummary> _memberState(MemberSummary? summary) =>
      summary == null ? const SectionEmpty() : SectionReady(summary);

  static SectionState<List<E>> _listState<E>(List<E> items) =>
      items.isEmpty ? SectionEmpty<List<E>>() : SectionReady(items);

  /// Bloc always emits its first state, even one equal to the initial
  /// state, so an unchanged state is skipped here.
  void _emitIfOpen(HomeState next) {
    if (!isClosed && next != state) emit(next);
  }

  @override
  Future<void> close() async {
    await Future.wait([for (final s in _subscriptions.values) s.cancel()]);
    _subscriptions.clear();
    await super.close();
  }
}
