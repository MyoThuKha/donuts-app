// Freezed's redirecting factory must keep the class name.
// ignore_for_file: unnecessary_type_name_in_constructor
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_detail_vo.freezed.dart';

/// One product as Product detail shows it.
@freezed
abstract class ProductDetailVO with _$ProductDetailVO {
  const factory ProductDetailVO({
    required String id,
    required String code,
    required String name,

    /// The list price, before any discount.
    required int priceMmk,
    required bool isNew,
    required String description,
    required String imageUrl,
    int? discountPercent,
    String? imageAsset,
  }) = _ProductDetailVO;

  const ProductDetailVO._();

  /// The price of one item after the discount, rounded down to the kyat.
  int get unitPriceMmk => priceMmk * (100 - (discountPercent ?? 0)) ~/ 100;

  /// What [quantity] items cost.
  int totalFor(int quantity) => unitPriceMmk * quantity;
}
