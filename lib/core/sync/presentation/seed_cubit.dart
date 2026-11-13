import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/sync/domain/usecases/seed_local_data_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SeedStatus { idle, seeding, done, failed }

/// Loads the bundled seed into the database on first launch.
///
/// A failure stays in the state, so Home can say the app couldn't set up
/// its data and offer [seed] again, and goes to [onError] for the logs.
class SeedCubit extends Cubit<SeedStatus> {
  new(this._seed) : super(SeedStatus.idle);

  final SeedLocalDataUseCase _seed;

  /// Does nothing while a seed is already running.
  Future<void> seed() async {
    if (state == SeedStatus.seeding) return;
    emit(SeedStatus.seeding);
    switch (await _seed()) {
      case Success():
        _emitIfOpen(SeedStatus.done);
      case Failure(:final failure):
        addError(failure, failure.stackTrace);
        _emitIfOpen(SeedStatus.failed);
    }
  }

  void _emitIfOpen(SeedStatus next) {
    if (!isClosed) emit(next);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final detail = error is AppFailure
        ? '${error.runtimeType} ${error.error}'
        : '$error';
    debugPrint('Seeding failed: $detail');
    super.onError(error, stackTrace);
  }
}
