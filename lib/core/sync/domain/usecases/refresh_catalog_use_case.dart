import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/sync/domain/catalog_sync_repository.dart';
import 'package:donuts/core/sync/domain/sync_outcome.dart';

class RefreshCatalogUseCase {
  const new(this._repository);

  final CatalogSyncRepository _repository;

  Future<Result<SyncOutcome>> call() => _repository.refreshCatalog();
}
