import 'package:donuts/core/state/section_state.dart';
import 'package:donuts/features/home/domain/vo/banner_vo.dart';
import 'package:donuts/features/home/domain/vo/home_product_vo.dart';
import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:donuts/features/home/domain/vo/shop_vo.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';
import 'package:equatable/equatable.dart';

/// The four parts of Home that load on their own. Each product row's
/// products load on their own too, keyed by the row's id in
/// [HomeState.rows].
enum HomeSectionId { member, banners, sections, shops }

final class HomeState extends Equatable {
  const new({
    this.member = const SectionLoading(),
    this.banners = const SectionLoading(),
    this.sections = const SectionLoading(),
    this.shops = const SectionLoading(),
    this.rows = const {},
  });

  final SectionState<MemberSummary> member;
  final SectionState<List<BannerVO>> banners;
  final SectionState<List<HomeSectionVO>> sections;
  final SectionState<List<ShopVO>> shops;

  /// Each product row's products, by row id. A row missing here is loading.
  final Map<String, SectionState<List<HomeProductVO>>> rows;

  /// The products of row [sectionId].
  SectionState<List<HomeProductVO>> row(String sectionId) =>
      rows[sectionId] ?? const SectionLoading();

  HomeState copyWith({
    SectionState<MemberSummary>? member,
    SectionState<List<BannerVO>>? banners,
    SectionState<List<HomeSectionVO>>? sections,
    SectionState<List<ShopVO>>? shops,
    Map<String, SectionState<List<HomeProductVO>>>? rows,
  }) => HomeState(
    member: member ?? this.member,
    banners: banners ?? this.banners,
    sections: sections ?? this.sections,
    shops: shops ?? this.shops,
    rows: rows ?? this.rows,
  );

  /// The same state with row [sectionId] set to [section].
  HomeState withRow(
    String sectionId,
    SectionState<List<HomeProductVO>> section,
  ) => copyWith(rows: {...rows, sectionId: section});

  @override
  List<Object?> get props => [member, banners, sections, shops, rows];

  @override
  bool get stringify => true;
}
