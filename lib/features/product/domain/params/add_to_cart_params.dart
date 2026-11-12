// Freezed's redirecting factory must keep the class name.
// ignore_for_file: unnecessary_type_name_in_constructor
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_to_cart_params.freezed.dart';

@freezed
abstract class AddToCartParams with _$AddToCartParams {
  const factory AddToCartParams({
    required String productId,
    required int quantity,
  }) = _AddToCartParams;
}
