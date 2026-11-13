import 'dart:io';

import 'package:donuts/core/widgets/images/tier_backdrop.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('each tier has its own backdrop, and others have none', () {
    final tiers = ['silver', 'gold', 'platinum'];
    final assets = {for (final id in tiers) TierBackdrop.assetFor(id)};
    expect(assets, hasLength(tiers.length));
    expect(assets, isNot(contains(null)));
    expect(TierBackdrop.assetFor('bronze'), isNull);
    expect(TierBackdrop.assetFor(null), isNull);
  });

  test('every tier backdrop is bundled', () {
    for (final id in ['silver', 'gold', 'platinum']) {
      expect(File(TierBackdrop.assetFor(id)!).existsSync(), isTrue);
    }
  });
}
