import 'dart:convert';
import 'dart:io';

import 'package:donuts/core/sync/data/dto/api_envelope.dart';
import 'package:donuts/core/sync/data/dto/catalog_dto.dart';
import 'package:donuts/core/sync/data/dto/member_dto.dart';

/// Paths of the committed data files, relative to the project root.
const seedCatalogPath = 'assets/seed/catalog_v1.json';
const seedMemberPath = 'assets/seed/member.json';
const remoteCatalogPath = 'mock-api/v1/catalog.json';

ApiEnvelope<CatalogDto> readCatalogFile(String path) =>
    ApiEnvelope<CatalogDto>.fromJson(
      _readJson(path),
      (data) => CatalogDto.fromJson(data! as Map<String, dynamic>),
    );

ApiEnvelope<MemberSeedDto> readMemberFile(String path) =>
    ApiEnvelope<MemberSeedDto>.fromJson(
      _readJson(path),
      (data) => MemberSeedDto.fromJson(data! as Map<String, dynamic>),
    );

Map<String, dynamic> _readJson(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
