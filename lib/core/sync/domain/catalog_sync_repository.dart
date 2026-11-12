import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/sync/domain/sync_outcome.dart';

/// Fills and refreshes the local database. Screens never call it for data:
/// they watch the database, which this repository writes to.
abstract interface class CatalogSyncRepository {
  /// Imports the bundled seed for any data set the database doesn't have.
  Future<Result<void>> seedIfNeeded();

  /// Fetches the remote catalog and imports it when it is newer.
  Future<Result<SyncOutcome>> refreshCatalog();
}
