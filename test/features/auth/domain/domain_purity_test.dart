import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('domain layers import nothing from Flutter or Dio', () {
    final offenders = <String>[];
    final domainFiles = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.contains('/domain/') && f.path.endsWith('.dart'));

    for (final file in domainFiles) {
      for (final line in file.readAsLinesSync()) {
        final importsFlutter =
            line.startsWith('import') &&
            (line.contains('package:flutter') ||
                line.contains('package:material_ui') ||
                line.contains('package:dio'));
        if (importsFlutter) offenders.add('${file.path}: $line');
      }
    }

    expect(domainFiles, isNotEmpty);
    expect(
      domainFiles.where((f) => f.path.contains('lib/core/sync/domain/')),
      isNotEmpty,
    );
    expect(offenders, isEmpty);
  });
}
