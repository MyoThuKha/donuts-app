import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/sync/data/catalog_integrity_exception.dart';
import 'package:donuts/core/sync/data/dto/catalog_dto.dart';
import 'package:donuts/core/sync/data/dto/member_dto.dart';
import 'package:donuts/core/sync/data/mapper/catalog_db_mapper.dart';

/// The `sync_state` keys of the data sets the importer writes.
abstract final class SyncKeys {
  static const String catalog = 'catalog';
  static const String member = 'member';
}

enum ImportOutcome { imported, skipped }

/// Writes a parsed catalog or member seed into Drift. Seed files and API
/// responses both come through here.
///
/// Each import is one transaction. A version that is not newer than the
/// stored one changes nothing but the fetch time, so a stale copy can never
/// roll the data back.
class CatalogImporter {
  new(this._db, {required this._now});

  final AppDatabase _db;
  final DateTime Function() _now;

  Future<bool> hasData(String key) async =>
      await _db.syncStateDao.find(key) != null;

  Future<ImportOutcome> importCatalog(
    CatalogDto catalog, {
    required int version,
  }) async {
    _checkIntegrity(catalog);
    return await _importVersioned(
      SyncKeys.catalog,
      version,
      () => _db.catalogDao.replaceCatalog(catalog.toRows()),
    );
  }

  Future<ImportOutcome> importMember(
    MemberSeedDto member, {
    required int version,
  }) => _importVersioned(
    SyncKeys.member,
    version,
    () => _db.memberDao.replaceMember(member.toRows()),
  );

  Future<ImportOutcome> _importVersioned(
    String key,
    int version,
    Future<void> Function() write,
  ) => _db.transaction(() async {
    final stored = await _db.syncStateDao.find(key);
    final isNewer = stored == null || version > stored.version;
    if (isNewer) await write();
    await _db.syncStateDao.save(
      key: key,
      version: isNewer ? version : stored.version,
      fetchedAt: _now(),
    );
    return isNewer ? ImportOutcome.imported : ImportOutcome.skipped;
  });

  void _checkIntegrity(CatalogDto catalog) {
    final productIds = <String>{};
    for (final product in catalog.products) {
      if (!productIds.add(product.id)) {
        throw CatalogIntegrityException('Repeated product id ${product.id}');
      }
    }
    for (final section in catalog.sections) {
      final missing = section.productIds.where(
        (id) => !productIds.contains(id),
      );
      if (missing.isNotEmpty) {
        throw CatalogIntegrityException(
          'Section ${section.id} names unknown products $missing',
        );
      }
    }
  }
}
