// Freezed's redirecting factory must keep the class name.
// ignore_for_file: unnecessary_type_name_in_constructor
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_product_vo.freezed.dart';

/// What a Home product tile shows.
@freezed
abstract class HomeProductVO with _$HomeProductVO {
  const factory HomeProductVO({
    required String id,
    required String name,
    required String imageUrl,
    int? discountPercent,
    String? imageAsset,
  }) = _HomeProductVO;
}
