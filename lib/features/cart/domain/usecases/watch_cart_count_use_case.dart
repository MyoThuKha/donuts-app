import 'package:donuts/features/cart/domain/repositories/cart_repository.dart';

class WatchCartCountUseCase {
  const new(this._repository);

  final CartRepository _repository;

  Stream<int> call() => _repository.watchCount();
}
