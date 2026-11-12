import 'package:donuts/features/home/domain/vo/banner_vo.dart';
import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:donuts/features/home/domain/vo/shop_vo.dart';

/// Home's content, read from the local catalog. Each stream emits again
/// whenever a refresh rewrites the catalog.
abstract interface class HomeRepository {
  Stream<List<BannerVO>> watchBanners();

  Stream<List<HomeSectionVO>> watchSections();

  Stream<List<ShopVO>> watchShops();
}
