import 'package:donuts/features/product/domain/vo/product_detail_vo.dart';

abstract interface class ProductRepository {
  /// Follows one product. Emits null while the catalog doesn't have it,
  /// for example after a refresh removed it.
  Stream<ProductDetailVO?> watchProduct(String id);
}
