import 'dart:convert';

import 'package:flutter/services.dart';

/// Loads every font family the pubspec declares, so text measures with the
/// real faces instead of the test font's 1 em squares. Myanmar script needs
/// this: its marks stack and combine, which the test font can't show.
Future<void> loadAppFonts() async {
  final manifest = await rootBundle.loadString('FontManifest.json');
  final families = (jsonDecode(manifest) as List<dynamic>)
      .cast<Map<String, dynamic>>();
  for (final family in families) {
    final loader = FontLoader(family['family'] as String);
    for (final font
        in (family['fonts'] as List<dynamic>).cast<Map<String, dynamic>>()) {
      loader.addFont(rootBundle.load(font['asset'] as String));
    }
    await loader.load();
  }
}
