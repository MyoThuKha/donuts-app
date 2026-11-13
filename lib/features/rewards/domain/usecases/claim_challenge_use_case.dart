import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/rewards/domain/repositories/rewards_repository.dart';

/// Earn on a completed challenge: its points go to the member's total.
class ClaimChallengeUseCase {
  const new(this._repository);

  final RewardsRepository _repository;

  Future<Result<void>> call(String challengeId) =>
      _repository.claimChallenge(challengeId);
}
