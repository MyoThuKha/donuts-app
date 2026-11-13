import 'package:flutter/services.dart';

/// Where the first-launch seed files are read from.
abstract interface class SeedSource {
  Future<String> load(String path);
}

/// Reads the seed from the app's bundled assets.
class AssetSeedSource implements SeedSource {
  const new(this._bundle);

  final AssetBundle _bundle;

  @override
  Future<String> load(String path) => _bundle.loadString(path);
}

abstract final class SeedPaths {
  static const String catalog = 'assets/seed/catalog_v1.json';
  static const String member = 'assets/seed/member.json';
}
