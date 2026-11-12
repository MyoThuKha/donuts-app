import 'dart:async';

import 'package:donuts/core/network/connectivity_cubit.dart';
import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/sync/domain/usecases/refresh_catalog_use_case.dart';
import 'package:donuts/core/sync/presentation/catalog_sync_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Refreshes the catalog in the background every time the app goes online,
/// which covers start-up and every reconnect.
///
/// Home's pull-to-refresh calls [refresh] too. Screens show the data from
/// the database, so a failed refresh only means a snackbar.
class CatalogSyncCubit extends Cubit<CatalogSyncState> {
  new({required this._refresh, required this._connectivity, required this._now})
    : super(const CatalogSyncState()) {
    _subscription = _connectivity.stream.listen(_onConnectivity);
  }

  final RefreshCatalogUseCase _refresh;
  final ConnectivityCubit _connectivity;
  final DateTime Function() _now;
  late final StreamSubscription<ConnectivityStatus> _subscription;

  /// Does nothing while a refresh is already running.
  Future<void> refresh() async {
    if (state.status == CatalogSyncStatus.syncing) return;
    if (_connectivity.state == ConnectivityStatus.offline) {
      return _fail(const NetworkFailure());
    }
    emit(_copy(CatalogSyncStatus.syncing));
    switch (await _refresh()) {
      case Success(:final data):
        _emitIfOpen(
          CatalogSyncState(
            status: CatalogSyncStatus.succeeded,
            outcome: data,
            lastSyncedAt: _now(),
          ),
        );
      case Failure(:final failure):
        _fail(failure);
        if (failure is NetworkFailure || failure is TimeoutFailure) {
          unawaited(_connectivity.recheck());
        }
    }
  }

  void _onConnectivity(ConnectivityStatus status) {
    if (status == ConnectivityStatus.online) unawaited(refresh());
  }

  void _fail(AppFailure failure) => _emitIfOpen(
    CatalogSyncState(
      status: CatalogSyncStatus.failed,
      failure: failure,
      outcome: state.outcome,
      lastSyncedAt: state.lastSyncedAt,
    ),
  );

  CatalogSyncState _copy(CatalogSyncStatus status) => CatalogSyncState(
    status: status,
    outcome: state.outcome,
    lastSyncedAt: state.lastSyncedAt,
  );

  void _emitIfOpen(CatalogSyncState next) {
    if (!isClosed) emit(next);
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    await super.close();
  }
}
