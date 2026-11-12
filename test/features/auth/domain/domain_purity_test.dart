import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('domain layers import nothing from Flutter', () {
    final offenders = <String>[];
    final domainFiles = Directory('lib/features')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.contains('/domain/') && f.path.endsWith('.dart'));

    for (final file in domainFiles) {
      for (final line in file.readAsLinesSync()) {
        final importsFlutter =
            line.startsWith('import') &&
            (line.contains('package:flutter') ||
                line.contains('package:material_ui'));
        if (importsFlutter) offenders.add('${file.path}: $line');
      }
    }

    expect(domainFiles, isNotEmpty);
    expect(offenders, isEmpty);
  });
}
