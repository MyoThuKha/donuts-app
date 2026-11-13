import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/sync/domain/sync_outcome.dart';
import 'package:equatable/equatable.dart';

enum CatalogSyncStatus { idle, syncing, succeeded, failed }

final class CatalogSyncState extends Equatable {
  const new({
    this.status = CatalogSyncStatus.idle,
    this.outcome,
    this.failure,
    this.lastSyncedAt,
  });

  final CatalogSyncStatus status;

  /// What the last successful refresh did.
  final SyncOutcome? outcome;

  /// Why the last refresh failed. Null unless [status] is `failed`.
  final AppFailure? failure;
  final DateTime? lastSyncedAt;

  @override
  List<Object?> get props => [status, outcome, failure, lastSyncedAt];

  @override
  bool get stringify => true;
}
