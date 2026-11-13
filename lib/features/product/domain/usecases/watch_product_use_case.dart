import 'package:donuts/features/product/domain/repositories/product_repository.dart';
import 'package:donuts/features/product/domain/vo/product_detail_vo.dart';

class WatchProductUseCase {
  const new(this._repository);

  final ProductRepository _repository;

  Stream<ProductDetailVO?> call(String id) => _repository.watchProduct(id);
}
