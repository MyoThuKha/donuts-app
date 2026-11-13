import 'package:donuts/core/database/daos/catalog_dao.dart';
import 'package:donuts/core/result/guard.dart';
import 'package:donuts/features/home/data/mapper/home_db_mapper.dart';
import 'package:donuts/features/home/domain/repositories/home_repository.dart';
import 'package:donuts/features/home/domain/vo/banner_vo.dart';
import 'package:donuts/features/home/domain/vo/home_product_vo.dart';
import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:donuts/features/home/domain/vo/shop_vo.dart';

class HomeRepositoryImpl implements HomeRepository {
  const new(this._dao);

  final CatalogDao _dao;

  @override
  Stream<List<BannerVO>> watchBanners() => _dao
      .watchBanners()
      .map((rows) => [for (final row in rows) row.toVO()])
      .guarded();

  @override
  Stream<List<HomeSectionVO>> watchSections() => _dao
      .watchSections()
      .map((rows) => [for (final row in rows) row.toVO()])
      .guarded();

  @override
  Stream<List<HomeProductVO>> watchSectionProducts(String sectionId) => _dao
      .watchSectionProducts(sectionId)
      .map((rows) => [for (final row in rows) row.toHomeProductVO()])
      .guarded();

  @override
  Stream<List<ShopVO>> watchShops() => _dao
      .watchShops()
      .map((rows) => [for (final row in rows) row.toVO()])
      .guarded();
}
