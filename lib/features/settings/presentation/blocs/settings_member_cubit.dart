import 'dart:async';

import 'package:donuts/features/rewards/domain/usecases/watch_member_summary_use_case.dart';
import 'package:donuts/features/rewards/domain/vo/member_summary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Follows the member summary in the local database for the Settings
/// header: the photo, the tier name and the tier's backdrop. Null until it
/// loads, or when there is no member or the stream fails.
class SettingsMemberCubit extends Cubit<MemberSummary?> {
  new(this._member) : super(null);

  final WatchMemberSummaryUseCase _member;
  StreamSubscription<MemberSummary?>? _subscription;

  void start() {
    unawaited(_subscription?.cancel());
    _subscription = _member().listen(
      _emitIfOpen,
      // The header keeps its plain colour and the initials.
      onError: (Object _, StackTrace _) => _emitIfOpen(null),
    );
  }

  void _emitIfOpen(MemberSummary? summary) {
    if (!isClosed) emit(summary);
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await super.close();
  }
}
