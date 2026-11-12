// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatalogDto _$CatalogDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_CatalogDto', json, ($checkedConvert) {
      final val = _CatalogDto(
        products: $checkedConvert(
          'products',
          (v) => (v as List<dynamic>)
              .map((e) => ProductDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        sections: $checkedConvert(
          'sections',
          (v) => (v as List<dynamic>)
              .map((e) => HomeSectionDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        banners: $checkedConvert(
          'banners',
          (v) => (v as List<dynamic>)
              .map((e) => BannerDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        shops: $checkedConvert(
          'shops',
          (v) => (v as List<dynamic>)
              .map((e) => ShopDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$CatalogDtoToJson(_CatalogDto instance) =>
    <String, dynamic>{
      'products': instance.products.map((e) => e.toJson()).toList(),
      'sections': instance.sections.map((e) => e.toJson()).toList(),
      'banners': instance.banners.map((e) => e.toJson()).toList(),
      'shops': instance.shops.map((e) => e.toJson()).toList(),
    };

_ProductDto _$ProductDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ProductDto', json, ($checkedConvert) {
      final val = _ProductDto(
        id: $checkedConvert('id', (v) => v as String),
        code: $checkedConvert('code', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        priceMmk: $checkedConvert('priceMmk', (v) => (v as num).toInt()),
        isNew: $checkedConvert('isNew', (v) => v as bool),
        description: $checkedConvert('description', (v) => v as String),
        imageUrl: $checkedConvert('imageUrl', (v) => v as String),
        updatedAt: $checkedConvert(
          'updatedAt',
          (v) => DateTime.parse(v as String),
        ),
        discountPercent: $checkedConvert(
          'discountPercent',
          (v) => (v as num?)?.toInt(),
        ),
        imageAsset: $checkedConvert('imageAsset', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ProductDtoToJson(_ProductDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'priceMmk': instance.priceMmk,
      'isNew': instance.isNew,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'discountPercent': instance.discountPercent,
      'imageAsset': instance.imageAsset,
    };

_HomeSectionDto _$HomeSectionDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_HomeSectionDto', json, ($checkedConvert) {
      final val = _HomeSectionDto(
        id: $checkedConvert('id', (v) => v as String),
        titleKey: $checkedConvert('titleKey', (v) => v as String),
        sortOrder: $checkedConvert('sortOrder', (v) => (v as num).toInt()),
        productIds: $checkedConvert(
          'productIds',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$HomeSectionDtoToJson(_HomeSectionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titleKey': instance.titleKey,
      'sortOrder': instance.sortOrder,
      'productIds': instance.productIds,
    };

_BannerDto _$BannerDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_BannerDto', json, ($checkedConvert) {
      final val = _BannerDto(
        id: $checkedConvert('id', (v) => v as String),
        tag: $checkedConvert('tag', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String),
        style: $checkedConvert(
          'style',
          (v) => $enumDecode(_$BannerStyleDtoEnumMap, v),
        ),
        imageUrl: $checkedConvert('imageUrl', (v) => v as String),
        sortOrder: $checkedConvert('sortOrder', (v) => (v as num).toInt()),
        imageAsset: $checkedConvert('imageAsset', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$BannerDtoToJson(_BannerDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag': instance.tag,
      'title': instance.title,
      'style': _$BannerStyleDtoEnumMap[instance.style]!,
      'imageUrl': instance.imageUrl,
      'sortOrder': instance.sortOrder,
      'imageAsset': instance.imageAsset,
    };

const _$BannerStyleDtoEnumMap = {
  BannerStyleDto.indigo: 'indigo',
  BannerStyleDto.sky: 'sky',
};

_ShopDto _$ShopDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_ShopDto', json, ($checkedConvert) {
      final val = _ShopDto(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        address: $checkedConvert('address', (v) => v as String),
        imageUrl: $checkedConvert('imageUrl', (v) => v as String),
        sortOrder: $checkedConvert('sortOrder', (v) => (v as num).toInt()),
        imageAsset: $checkedConvert('imageAsset', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ShopDtoToJson(_ShopDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'address': instance.address,
  'imageUrl': instance.imageUrl,
  'sortOrder': instance.sortOrder,
  'imageAsset': instance.imageAsset,
};
