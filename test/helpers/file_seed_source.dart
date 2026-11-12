import 'dart:io';

import 'package:donuts/core/sync/data/seed_source.dart';

/// Reads seed files from the project folder instead of the asset bundle,
/// and counts the loads.
class FileSeedSource implements SeedSource {
  int loads = 0;

  @override
  Future<String> load(String path) {
    loads++;
    return File(path).readAsString();
  }
}
