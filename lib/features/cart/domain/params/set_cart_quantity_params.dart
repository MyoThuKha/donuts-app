// Freezed's redirecting factory must keep the class name.
// ignore_for_file: unnecessary_type_name_in_constructor
import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_cart_quantity_params.freezed.dart';

@freezed
abstract class SetCartQuantityParams with _$SetCartQuantityParams {
  const factory SetCartQuantityParams({
    required String productId,
    required int quantity,
  }) = _SetCartQuantityParams;
}
