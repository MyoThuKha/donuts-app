import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/cart/domain/repositories/cart_repository.dart';

class ClearCartUseCase {
  const new(this._repository);

  final CartRepository _repository;

  Future<Result<void>> call() => _repository.clear();
}
