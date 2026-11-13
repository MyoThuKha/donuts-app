// Freezed's redirecting factory must keep the class name.
// ignore_for_file: unnecessary_type_name_in_constructor
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tier_vo.freezed.dart';

/// A membership tier and the points it starts at.
@freezed
abstract class TierVO with _$TierVO {
  const factory TierVO({
    required String id,
    required String name,
    required int minPoints,

    /// Position on the ladder, 0 for the lowest tier.
    required int sortOrder,

    /// The tier's badge, cached from the network with [imageAsset] as
    /// the bundled fallback.
    String? imageUrl,
    String? imageAsset,
  }) = _TierVO;
}
