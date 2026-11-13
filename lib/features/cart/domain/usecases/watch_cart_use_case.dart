import 'package:donuts/features/cart/domain/repositories/cart_repository.dart';
import 'package:donuts/features/cart/domain/vo/cart_vo.dart';

class WatchCartUseCase {
  const new(this._repository);

  final CartRepository _repository;

  Stream<CartVO> call() => _repository.watchCart();
}
