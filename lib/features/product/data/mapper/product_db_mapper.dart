import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/features/product/domain/vo/product_detail_vo.dart';

extension ProductsTableDataMapper on ProductsTableData {
  ProductDetailVO toDetailVO() => ProductDetailVO(
    id: id,
    code: code,
    name: name,
    priceMmk: priceMmk,
    isNew: isNew,
    discountPercent: discountPercent,
    description: description,
    imageUrl: imageUrl,
    imageAsset: imageAsset,
  );
}
