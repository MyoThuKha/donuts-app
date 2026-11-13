import 'dart:io';

import 'package:donuts/core/sync/data/dto/catalog_dto.dart';
import 'package:donuts/core/sync/data/dto/member_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/seed_files.dart';

void _expectSectionsReferenceKnownProducts(CatalogDto catalog) {
  final ids = {for (final p in catalog.products) p.id};
  for (final section in catalog.sections) {
    expect(ids, containsAll(section.productIds), reason: section.id);
  }
}

/// Every image a catalog names, as (id, imageUrl, imageAsset).
List<(String, String?, String?)> _catalogImages(CatalogDto catalog) => [
  for (final p in catalog.products) (p.id, p.imageUrl, p.imageAsset),
  for (final b in catalog.banners) (b.id, b.imageUrl, b.imageAsset),
  for (final s in catalog.shops) (s.id, s.imageUrl, s.imageAsset),
  for (final g in catalog.gifts) (g.id, g.imageUrl, g.imageAsset),
];

/// Every tier and challenge image the member seed names.
List<(String, String?, String?)> _memberImages(MemberSeedDto member) => [
  for (final t in member.tiers) (t.id, t.imageUrl, t.imageAsset),
  for (final c in member.challenges) (c.id, c.imageUrl, c.imageAsset),
];

/// The bundled copy of a mock API image path: `assets/home/box.jpg` is
/// bundled as `assets/seed/images/home/box.jpg`.
String _bundledCopyOf(String imageUrl) =>
    'assets/seed/images/${imageUrl.substring('assets/'.length)}';

void main() {
  test('the seed catalog parses with version 2 and 10 products', () {
    final seed = readCatalogFile(seedCatalogPath);

    expect(seed.meta.version, 2);
    expect(seed.data!.products, hasLength(10));
    expect(seed.data!.shops, hasLength(4));
  });

  test('every seed image has a bundled copy identical to the mock API file, '
      'in a folder pubspec.yaml declares', () {
    final images = [
      ..._catalogImages(readCatalogFile(seedCatalogPath).data!),
      ..._memberImages(readMemberFile(seedMemberPath).data!),
    ];
    final pubspec = File('pubspec.yaml').readAsStringSync();

    expect(images, isNotEmpty);
    for (final (id, url, asset) in images) {
      expect(url, isNotNull, reason: id);
      expect(asset, _bundledCopyOf(url!), reason: id);
      final bundled = File(asset!);
      expect(bundled.existsSync(), isTrue, reason: '$id: $asset');
      expect(
        bundled.readAsBytesSync(),
        File('mock-api/$url').readAsBytesSync(),
        reason: '$id: $asset differs from mock-api/$url',
      );
      expect(pubspec, contains('- ${bundled.parent.path}/\n'), reason: id);
    }
  });

  test('the remote catalog names the same bundled copy as the seed for '
      'every product, banner, shop and gift the seed has', () {
    final seedAssets = {
      for (final (id, _, asset) in _catalogImages(
        readCatalogFile(seedCatalogPath).data!,
      ))
        id: asset,
    };

    for (final (id, _, asset) in _catalogImages(
      readCatalogFile(remoteCatalogPath).data!,
    )) {
      if (!seedAssets.containsKey(id)) continue;
      expect(asset, seedAssets[id], reason: id);
    }
  });

  test(
    'the remote catalog has version 5 and exactly one product the seed lacks',
    () {
      final seedIds = {
        for (final p in readCatalogFile(seedCatalogPath).data!.products) p.id,
      };
      final remote = readCatalogFile(remoteCatalogPath);
      final added = remote.data!.products.where((p) => !seedIds.contains(p.id));

      expect(remote.meta.version, 5);
      expect(added.map((p) => p.id), ['p_toasted_coconut']);
      expect(added.single.imageAsset, isNull);
    },
  );

  test('every section product id exists in its catalog', () {
    _expectSectionsReferenceKnownProducts(
      readCatalogFile(seedCatalogPath).data!,
    );
    _expectSectionsReferenceKnownProducts(
      readCatalogFile(remoteCatalogPath).data!,
    );
  });

  test('the Coconut Donut matches the reference product', () {
    final coconut = readCatalogFile(seedCatalogPath).data!.products
        .singleWhere((p) => p.id == 'p_coconut');

    expect(coconut.code, 'JD022123');
    expect(coconut.priceMmk, 3200);
    expect(coconut.isNew, isTrue);
    expect(coconut.discountPercent, isNull);
  });

  test('the member seed puts 680,300 points 200 short of Gold, which the '
      'complete Coco challenge pays', () {
    final member = readMemberFile(seedMemberPath).data!;
    final silver = member.tiers.singleWhere((t) => t.id == 'silver');
    final gold = member.tiers.singleWhere((t) => t.id == 'gold');
    final progress =
        (member.profile.totalPoints - silver.minPoints) /
        (gold.minPoints - silver.minPoints);

    final coco = member.challenges.singleWhere((c) => c.id == 'c_coco_donuts');

    expect(member.profile.totalPoints, 680300);
    expect(progress, closeTo(0.9, 1e-9));
    expect(gold.minPoints - member.profile.totalPoints, 200);
    expect(coco.progress, coco.target);
    expect(coco.rewardPoints, 200);
  });
}
