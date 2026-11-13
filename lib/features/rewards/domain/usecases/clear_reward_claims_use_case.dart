import 'package:donuts/features/rewards/domain/repositories/rewards_repository.dart';

/// Undoes every Earn, as a refresh does.
class ClearRewardClaimsUseCase {
  const new(this._repository);

  final RewardsRepository _repository;

  void call() => _repository.clearClaims();
}
