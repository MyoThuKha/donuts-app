import 'dart:io';

import 'package:donuts/core/network/api_exception.dart';
import 'package:donuts/core/sync/data/catalog_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/scripted_adapter.dart';
import '../../../helpers/seed_files.dart';

CatalogRemoteDataSource _sourceReplying(ScriptedResponse reply) =>
    CatalogRemoteDataSource(scriptedDio(ScriptedAdapter([reply])));

void main() {
  test('fetchCatalog parses a plain-text body', () async {
    final body = File(remoteCatalogPath).readAsStringSync();

    final envelope = await _sourceReplying(ScriptedResponse(200, body))
        .fetchCatalog();

    expect(envelope.meta.version, 4);
    expect(envelope.data!.products, hasLength(11));
  });

  test('an envelope with an error throws ApiException', () async {
    final body = jsonBody({
      'data': null,
      'error': {'code': 'maintenance', 'message': 'Back soon'},
      'meta': {'version': 2, 'generatedAt': '2026-11-12T00:00:00Z'},
    });

    await expectLater(
      _sourceReplying(ScriptedResponse(200, body)).fetchCatalog(),
      throwsA(isA<ApiException>().having((e) => e.code, 'code', 'maintenance')),
    );
  });

  test('an HTML body throws FormatException', () async {
    await expectLater(
      _sourceReplying(
        const ScriptedResponse(200, '<html>Sign in to Wi-Fi</html>'),
      ).fetchCatalog(),
      throwsA(isA<FormatException>()),
    );
  });
}
