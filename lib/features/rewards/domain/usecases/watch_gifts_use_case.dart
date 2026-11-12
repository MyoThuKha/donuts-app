import 'package:donuts/features/rewards/domain/repositories/rewards_repository.dart';
import 'package:donuts/features/rewards/domain/vo/gift_vo.dart';

class WatchGiftsUseCase {
  const new(this._repository);

  final RewardsRepository _repository;

  Stream<List<GiftVO>> call() => _repository.watchGifts();
}
