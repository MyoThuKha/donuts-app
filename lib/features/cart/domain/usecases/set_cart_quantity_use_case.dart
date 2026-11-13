import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/cart/domain/params/set_cart_quantity_params.dart';
import 'package:donuts/features/cart/domain/repositories/cart_repository.dart';

class SetCartQuantityUseCase {
  const new(this._repository);

  final CartRepository _repository;

  Future<Result<void>> call(SetCartQuantityParams params) =>
      _repository.setQuantity(params.productId, params.quantity);
}
