import 'package:donuts/features/home/domain/vo/banner_vo.dart';
import 'package:donuts/features/home/domain/vo/home_product_vo.dart';
import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:donuts/features/home/domain/vo/shop_vo.dart';

/// Home's content, read from the local catalog. Each stream emits again
/// whenever a refresh rewrites the catalog.
abstract interface class HomeRepository {
  Stream<List<BannerVO>> watchBanners();

  /// The product rows, in display order, without their products.
  Stream<List<HomeSectionVO>> watchSections();

  /// The products of row [sectionId], in display order.
  Stream<List<HomeProductVO>> watchSectionProducts(String sectionId);

  Stream<List<ShopVO>> watchShops();
}
