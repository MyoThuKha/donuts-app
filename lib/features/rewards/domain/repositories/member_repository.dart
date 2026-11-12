import 'package:donuts/features/rewards/domain/vo/member_summary.dart';

abstract interface class MemberRepository {
  /// Emits null until the member data has been seeded.
  Stream<MemberSummary?> watchSummary();
}
