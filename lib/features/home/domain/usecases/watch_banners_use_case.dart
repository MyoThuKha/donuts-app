import 'package:donuts/features/home/domain/repositories/home_repository.dart';
import 'package:donuts/features/home/domain/vo/banner_vo.dart';

class WatchBannersUseCase {
  const new(this._repository);

  final HomeRepository _repository;

  Stream<List<BannerVO>> call() => _repository.watchBanners();
}
