import 'package:donuts/core/state/section_state.dart';
import 'package:donuts/core/state/section_watcher.dart';
import 'package:donuts/features/home/domain/usecases/watch_banners_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_home_sections_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_section_products_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_shops_use_case.dart';
import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:donuts/features/home/presentation/blocs/home_state.dart';
import 'package:donuts/features/rewards/domain/usecases/clear_reward_claims_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_member_summary_use_case.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Follows the four Home streams, each into its own [SectionState], and
/// each product row's products into its own entry of [HomeState.rows].
/// Parts are keyed by [HomeSectionId], rows by `(row: id)`.
class HomeCubit extends Cubit<HomeState>
    with SectionWatcher<Object, HomeState> {
  new({
    required this._member,
    required this._banners,
    required this._sections,
    required this._sectionProducts,
    required this._shops,
    required this._clearRewardClaims,
  }) : super(const HomeState());

  final WatchMemberSummaryUseCase _member;
  final WatchBannersUseCase _banners;
  final WatchHomeSectionsUseCase _sections;
  final WatchSectionProductsUseCase _sectionProducts;
  final WatchShopsUseCase _shops;
  final ClearRewardClaimsUseCase _clearRewardClaims;

  /// Subscribes to every section.
  void start() => HomeSectionId.values.forEach(retry);

  /// Shows [id] as loading again and subscribes to it afresh.
  void retry(HomeSectionId id) => switch (id) {
    HomeSectionId.member => watchSection(
      id,
      _member().map(_memberState),
      (section) => state.copyWith(member: section),
    ),
    HomeSectionId.banners => watchSection(
      id,
      _banners().map(listSection),
      (section) => state.copyWith(banners: section),
    ),
    HomeSectionId.sections => watchSection(
      id,
      _sections().map(listSection),
      _putSections,
    ),
    HomeSectionId.shops => watchSection(
      id,
      _shops().map(listSection),
      (section) => state.copyWith(shops: section),
    ),
  };

  /// Shows row [sectionId]'s products as loading again and follows them
  /// afresh.
  void retryRow(String sectionId) => watchSection(
    (row: sectionId),
    _sectionProducts(sectionId).map(listSection),
    (section) => state.withRow(sectionId, section),
  );

  /// Undoes any Earn from Rewards. The header follows the member summary,
  /// so it shows the stored points again.
  void resetRewardClaims() => _clearRewardClaims();

  /// Starts following the products of rows that arrived and stops
  /// following rows that left, then stores [section].
  HomeState _putSections(SectionState<List<HomeSectionVO>> section) {
    if (section case SectionReady(:final data)) {
      final ids = {for (final row in data) row.id};
      for (final gone in state.rows.keys.where((id) => !ids.contains(id))) {
        unwatchSection((row: gone));
      }
      ids.where((id) => !state.rows.containsKey(id)).forEach(retryRow);
      return state.copyWith(
        sections: section,
        rows: {
          for (final entry in state.rows.entries)
            if (ids.contains(entry.key)) entry.key: entry.value,
        },
      );
    }
    return state.copyWith(sections: section);
  }

  static SectionState<MemberSummary> _memberState(MemberSummary? summary) =>
      summary == null ? const SectionEmpty() : SectionReady(summary);
}
