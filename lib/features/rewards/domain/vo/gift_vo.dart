// Freezed's redirecting factory must keep the class name.
// ignore_for_file: unnecessary_type_name_in_constructor
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gift_vo.freezed.dart';

/// A gift on the Gift tab that the member can redeem with points.
@freezed
abstract class GiftVO with _$GiftVO {
  const factory GiftVO({
    required String id,
    required String title,
    required int costPoints,
    String? imageAsset,
  }) = _GiftVO;
}
