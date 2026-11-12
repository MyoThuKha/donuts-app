import 'package:donuts/features/rewards/domain/repositories/member_repository.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';

class WatchMemberSummaryUseCase {
  const new(this._repository);

  final MemberRepository _repository;

  Stream<MemberSummary?> call() => _repository.watchSummary();
}
