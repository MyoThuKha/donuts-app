import 'package:donuts/core/sync/data/dto/api_envelope.dart';
import 'package:donuts/core/sync/data/dto/catalog_dto.dart';
import 'package:donuts/core/sync/data/dto/member_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_annotation/json_annotation.dart';

Map<String, dynamic> _product({Object priceMmk = 3200}) => {
  'id': 'p_coconut',
  'code': 'JD022123',
  'name': 'Coconut Donut',
  'priceMmk': priceMmk,
  'isNew': true,
  'discountPercent': null,
  'description': 'Enjoy our scrumptious donuts',
  'imageUrl': 'https://example.com/donut.webp',
  'imageAsset': 'assets/images/donut.webp',
  'updatedAt': '2026-11-12T00:00:00Z',
};

Map<String, dynamic> _catalog({Map<String, dynamic>? product}) => {
  'data': {
    'products': [product ?? _product()],
    'sections': [
      {
        'id': 'popular',
        'titleKey': 'popular',
        'sortOrder': 1,
        'productIds': ['p_coconut'],
      },
    ],
    'banners': [
      {
        'id': 'b_hot_drinks',
        'tag': '50% off',
        'title': 'Hot drinks are here',
        'style': 'sky',
        'imageUrl': 'https://example.com/banner.webp',
        'imageAsset': null,
        'sortOrder': 0,
      },
    ],
    'shops': [
      {
        'id': 's_downtown',
        'name': "J'Donuts Downtown",
        'address': 'Yangon',
        'imageUrl': 'https://example.com/shop.webp',
        'imageAsset': null,
        'sortOrder': 0,
      },
    ],
  },
  'error': null,
  'meta': {'version': 1, 'generatedAt': '2026-11-12T00:00:00Z'},
};

ApiEnvelope<CatalogDto> _parseCatalog(Map<String, dynamic> json) =>
    ApiEnvelope<CatalogDto>.fromJson(
      json,
      (data) => CatalogDto.fromJson(data! as Map<String, dynamic>),
    );

void main() {
  test('a catalog envelope parses products, sections, banners and shops', () {
    final envelope = _parseCatalog(_catalog());

    expect(envelope.meta.version, 1);
    expect(envelope.error, isNull);
    final catalog = envelope.data!;
    expect(catalog.products.single.priceMmk, 3200);
    expect(catalog.products.single.discountPercent, isNull);
    expect(catalog.sections.single.productIds, ['p_coconut']);
    expect(catalog.banners.single.style, BannerStyleDto.sky);
    expect(catalog.shops.single.name, "J'Donuts Downtown");
  });

  test(
    'a product whose priceMmk is a string throws CheckedFromJsonException',
    () {
      expect(
        () => _parseCatalog(_catalog(product: _product(priceMmk: '3200'))),
        throwsA(isA<CheckedFromJsonException>()),
      );
    },
  );

  test('an unknown challenge kind throws CheckedFromJsonException', () {
    expect(
      () => ChallengeDto.fromJson({
        'id': 'c_x',
        'title': 'Eat 4 Coco donuts',
        'kind': 'pizzaSlices',
        'progress': 1,
        'target': 4,
        'rewardPoints': 100,
        'imageAsset': null,
        'sortOrder': 0,
      }),
      throwsA(isA<CheckedFromJsonException>()),
    );
  });
}
