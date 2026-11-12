import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/database/daos/catalog_dao.dart';
import 'package:donuts/features/home/domain/types/banner_style.dart';
import 'package:donuts/features/home/domain/vo/banner_vo.dart';
import 'package:donuts/features/home/domain/vo/home_product_vo.dart';
import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:donuts/features/home/domain/vo/shop_vo.dart';

extension BannersTableDataMapper on BannersTableData {
  BannerVO toVO() => BannerVO(
    id: id,
    tag: tag,
    title: title,
    style: BannerStyle.parse(style),
    imageUrl: imageUrl,
    imageAsset: imageAsset,
  );
}

extension ProductsTableDataHomeMapper on ProductsTableData {
  HomeProductVO toHomeProductVO() => HomeProductVO(
    id: id,
    name: name,
    discountPercent: discountPercent,
    imageUrl: imageUrl,
    imageAsset: imageAsset,
  );
}

extension SectionWithProductsMapper on SectionWithProducts {
  HomeSectionVO toVO() => HomeSectionVO(
    id: section.id,
    titleKey: section.titleKey,
    kind: HomeSectionKind.fromTitleKey(section.titleKey),
    products: [for (final p in products) p.toHomeProductVO()],
  );
}

extension ShopsTableDataMapper on ShopsTableData {
  ShopVO toVO() => ShopVO(
    id: id,
    name: name,
    address: address,
    imageUrl: imageUrl,
    imageAsset: imageAsset,
  );
}
