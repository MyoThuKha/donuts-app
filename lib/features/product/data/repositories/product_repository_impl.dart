import 'package:donuts/core/database/daos/catalog_dao.dart';
import 'package:donuts/features/product/data/mapper/product_db_mapper.dart';
import 'package:donuts/features/product/domain/repositories/product_repository.dart';
import 'package:donuts/features/product/domain/vo/product_detail_vo.dart';

class ProductRepositoryImpl implements ProductRepository {
  const new(this._dao);

  final CatalogDao _dao;

  @override
  Stream<ProductDetailVO?> watchProduct(String id) =>
      _dao.watchProduct(id).map((row) => row?.toDetailVO());
}
