import 'package:donuts/features/home/domain/repositories/home_repository.dart';
import 'package:donuts/features/home/domain/vo/shop_vo.dart';

class WatchShopsUseCase {
  const new(this._repository);

  final HomeRepository _repository;

  Stream<List<ShopVO>> call() => _repository.watchShops();
}
