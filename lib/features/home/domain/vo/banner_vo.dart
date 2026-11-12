// Freezed's redirecting factory must keep the class name.
// ignore_for_file: unnecessary_type_name_in_constructor
import 'package:donuts/features/home/domain/types/banner_style.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'banner_vo.freezed.dart';

/// One card in Home's banner carousel.
@freezed
abstract class BannerVO with _$BannerVO {
  const factory BannerVO({
    required String id,
    required String tag,
    required String title,
    required BannerStyle style,
    required String imageUrl,
    String? imageAsset,
  }) = _BannerVO;
}
