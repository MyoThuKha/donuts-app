// Freezed's redirecting factory must keep the class name.
// ignore_for_file: unnecessary_type_name_in_constructor
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop_vo.freezed.dart';

/// A nearby J'Donuts shop in Home's shops band.
@freezed
abstract class ShopVO with _$ShopVO {
  const factory ShopVO({
    required String id,
    required String name,
    required String address,
    required String imageUrl,
    String? imageAsset,
  }) = _ShopVO;
}
