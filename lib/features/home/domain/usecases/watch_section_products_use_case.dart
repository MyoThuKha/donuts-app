import 'package:donuts/features/home/domain/repositories/home_repository.dart';
import 'package:donuts/features/home/domain/vo/home_product_vo.dart';

class WatchSectionProductsUseCase {
  const new(this._repository);

  final HomeRepository _repository;

  Stream<List<HomeProductVO>> call(String sectionId) =>
      _repository.watchSectionProducts(sectionId);
}
