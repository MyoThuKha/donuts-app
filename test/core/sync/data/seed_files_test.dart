import 'package:donuts/core/sync/data/dto/catalog_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/seed_files.dart';

void _expectSectionsReferenceKnownProducts(CatalogDto catalog) {
  final ids = {for (final p in catalog.products) p.id};
  for (final section in catalog.sections) {
    expect(ids, containsAll(section.productIds), reason: section.id);
  }
}

void main() {
  test('the seed catalog parses with version 2 and 10 products', () {
    final seed = readCatalogFile(seedCatalogPath);

    expect(seed.meta.version, 2);
    expect(seed.data!.products, hasLength(10));
    expect(seed.data!.shops, hasLength(4));
  });

  test(
    'the remote catalog has version 3 and exactly one product the seed lacks',
    () {
      final seedIds = {
        for (final p in readCatalogFile(seedCatalogPath).data!.products) p.id,
      };
      final remote = readCatalogFile(remoteCatalogPath);
      final added = remote.data!.products.where((p) => !seedIds.contains(p.id));

      expect(remote.meta.version, 3);
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
