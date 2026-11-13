import 'package:donuts/features/rewards/domain/repositories/rewards_repository.dart';
import 'package:donuts/features/rewards/domain/vo/challenge_vo.dart';

class WatchChallengesUseCase {
  const new(this._repository);

  final RewardsRepository _repository;

  Stream<List<ChallengeVO>> call() => _repository.watchChallenges();
}
