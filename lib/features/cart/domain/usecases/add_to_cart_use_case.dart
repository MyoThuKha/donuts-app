import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/cart/domain/params/add_to_cart_params.dart';
import 'package:donuts/features/cart/domain/repositories/cart_repository.dart';

class AddToCartUseCase {
  const new(this._repository);

  final CartRepository _repository;

  Future<Result<void>> call(AddToCartParams params) =>
      _repository.add(params.productId, params.quantity);
}
