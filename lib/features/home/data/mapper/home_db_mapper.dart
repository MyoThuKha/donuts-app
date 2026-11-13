import 'package:donuts/core/database/app_database.dart';
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

extension HomeSectionsTableDataMapper on HomeSectionsTableData {
  HomeSectionVO toVO() => HomeSectionVO(
    id: id,
    titleKey: titleKey,
    kind: HomeSectionKind.fromTitleKey(titleKey),
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
