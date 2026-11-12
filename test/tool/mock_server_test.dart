import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../../tool/mock_server.dart';

void main() {
  final root = Directory('mock-api').absolute;

  test('resolves a catalog path inside mock-api', () {
    final file = resolveMockFile(root, Uri.parse('/v1/catalog.json'));

    expect(file?.path, endsWith('catalog.json'));
  });

  test('rejects a path that climbs out of mock-api with ..', () {
    expect(resolveMockFile(root, Uri.parse('/../pubspec.yaml')), isNull);
  });

  test('rejects an encoded slash that climbs out of mock-api', () {
    expect(
      resolveMockFile(root, Uri.parse('/v1%2F..%2F..%2Fpubspec.yaml')),
      isNull,
    );
  });
}
