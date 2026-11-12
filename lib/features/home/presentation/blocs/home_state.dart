import 'package:donuts/features/home/domain/vo/banner_vo.dart';
import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:donuts/features/home/domain/vo/shop_vo.dart';
import 'package:donuts/features/home/presentation/blocs/section_state.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';
import 'package:equatable/equatable.dart';

/// The four parts of Home that load on their own.
enum HomeSectionId { member, banners, sections, shops }

final class HomeState extends Equatable {
  const new({
    this.member = const SectionLoading(),
    this.banners = const SectionLoading(),
    this.sections = const SectionLoading(),
    this.shops = const SectionLoading(),
  });

  final SectionState<MemberSummary> member;
  final SectionState<List<BannerVO>> banners;
  final SectionState<List<HomeSectionVO>> sections;
  final SectionState<List<ShopVO>> shops;

  HomeState copyWith({
    SectionState<MemberSummary>? member,
    SectionState<List<BannerVO>>? banners,
    SectionState<List<HomeSectionVO>>? sections,
    SectionState<List<ShopVO>>? shops,
  }) => HomeState(
    member: member ?? this.member,
    banners: banners ?? this.banners,
    sections: sections ?? this.sections,
    shops: shops ?? this.shops,
  );

  @override
  List<Object?> get props => [member, banners, sections, shops];

  @override
  bool get stringify => true;
}
