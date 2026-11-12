import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/sync/domain/catalog_sync_repository.dart';

class SeedLocalDataUseCase {
  const new(this._repository);

  final CatalogSyncRepository _repository;

  Future<Result<void>> call() => _repository.seedIfNeeded();
}
