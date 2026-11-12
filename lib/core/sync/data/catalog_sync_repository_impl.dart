import 'dart:convert';

import 'package:donuts/core/result/guard.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/sync/data/catalog_importer.dart';
import 'package:donuts/core/sync/data/catalog_remote_data_source.dart';
import 'package:donuts/core/sync/data/dto/api_envelope.dart';
import 'package:donuts/core/sync/data/dto/catalog_dto.dart';
import 'package:donuts/core/sync/data/dto/member_dto.dart';
import 'package:donuts/core/sync/data/seed_source.dart';
import 'package:donuts/core/sync/domain/catalog_sync_repository.dart';
import 'package:donuts/core/sync/domain/sync_outcome.dart';

class CatalogSyncRepositoryImpl implements CatalogSyncRepository {
  const new({
    required this._seed,
    required this._remote,
    required this._importer,
  });

  final SeedSource _seed;
  final CatalogRemoteDataSource _remote;
  final CatalogImporter _importer;

  @override
  Future<Result<void>> seedIfNeeded() => guard(() async {
    if (!await _importer.hasData(SyncKeys.catalog)) {
      final seed = await _loadEnvelope(SeedPaths.catalog, CatalogDto.fromJson);
      await _importer.importCatalog(seed.data!, version: seed.meta.version);
    }
    if (!await _importer.hasData(SyncKeys.member)) {
      final seed = await _loadEnvelope(
        SeedPaths.member,
        MemberSeedDto.fromJson,
      );
      await _importer.importMember(seed.data!, version: seed.meta.version);
    }
  });

  @override
  Future<Result<SyncOutcome>> refreshCatalog() => guard(() async {
    final envelope = await _remote.fetchCatalog();
    final outcome = await _importer.importCatalog(
      envelope.data!,
      version: envelope.meta.version,
    );
    return switch (outcome) {
      ImportOutcome.imported => SyncOutcome.updated,
      ImportOutcome.skipped => SyncOutcome.upToDate,
    };
  });

  Future<ApiEnvelope<T>> _loadEnvelope<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final json = jsonDecode(await _seed.load(path));
    if (json is! Map<String, dynamic>) {
      throw FormatException('$path is not a JSON object');
    }
    final envelope = ApiEnvelope<T>.fromJson(
      json,
      (data) => fromJson(data! as Map<String, dynamic>),
    );
    if (envelope.data == null) throw FormatException('$path has no data');
    return envelope;
  }
}
