// Freezed's redirecting factory must keep the class name.
// ignore_for_file: unnecessary_type_name_in_constructor
import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_dto.freezed.dart';
part 'catalog_dto.g.dart';

/// The public catalog: what `GET v1/catalog.json` returns and what the seed
/// bundles.
@freezed
abstract class CatalogDto with _$CatalogDto {
  const factory CatalogDto({
    required List<ProductDto> products,
    required List<HomeSectionDto> sections,
    required List<BannerDto> banners,
    required List<ShopDto> shops,

    /// The Rewards gifts. An older catalog without them reads as none.
    @Default(<GiftDto>[]) List<GiftDto> gifts,
  }) = _CatalogDto;

  factory fromJson(Map<String, dynamic> json) => _$CatalogDtoFromJson(json);
}

@freezed
abstract class ProductDto with _$ProductDto {
  const factory ProductDto({
    required String id,
    required String code,
    required String name,
    required int priceMmk,
    required bool isNew,
    required String description,
    required String imageUrl,
    required DateTime updatedAt,
    int? discountPercent,
    String? imageAsset,
  }) = _ProductDto;

  factory fromJson(Map<String, dynamic> json) => _$ProductDtoFromJson(json);
}

@freezed
abstract class HomeSectionDto with _$HomeSectionDto {
  const factory HomeSectionDto({
    required String id,
    required String titleKey,
    required int sortOrder,
    required List<String> productIds,
  }) = _HomeSectionDto;

  factory fromJson(Map<String, dynamic> json) => _$HomeSectionDtoFromJson(json);
}

/// Banner colours are theme tokens, never hex values from the server.
enum BannerStyleDto { indigo, sky }

@freezed
abstract class BannerDto with _$BannerDto {
  const factory BannerDto({
    required String id,
    required String tag,
    required String title,
    required BannerStyleDto style,
    required String imageUrl,
    required int sortOrder,
    String? imageAsset,
  }) = _BannerDto;

  factory fromJson(Map<String, dynamic> json) => _$BannerDtoFromJson(json);
}

@freezed
abstract class ShopDto with _$ShopDto {
  const factory ShopDto({
    required String id,
    required String name,
    required String address,
    required String imageUrl,
    required int sortOrder,
    String? imageAsset,
  }) = _ShopDto;

  factory fromJson(Map<String, dynamic> json) => _$ShopDtoFromJson(json);
}

@freezed
abstract class GiftDto with _$GiftDto {
  const factory GiftDto({
    required String id,
    required String title,
    required int costPoints,
    required int sortOrder,
    String? imageUrl,
    String? imageAsset,
  }) = _GiftDto;

  factory fromJson(Map<String, dynamic> json) => _$GiftDtoFromJson(json);
}
