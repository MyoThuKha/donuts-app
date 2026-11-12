// Freezed's redirecting factory must keep the class name.
// ignore_for_file: unnecessary_type_name_in_constructor
import 'package:donuts/features/home/domain/vo/home_product_vo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_section_vo.freezed.dart';

/// The product rows Home knows a title for. Any other row is [other] and
/// shows its raw title key.
enum HomeSectionKind {
  seasonal,
  popular,
  orderAgain,
  other;

  static HomeSectionKind fromTitleKey(String titleKey) => switch (titleKey) {
    'seasonal' => seasonal,
    'popular' => popular,
    'order_again' => orderAgain,
    _ => other,
  };
}

/// One horizontal product row on Home.
@freezed
abstract class HomeSectionVO with _$HomeSectionVO {
  const factory HomeSectionVO({
    required String id,

    /// The catalog's title key. Shown as is when [kind] is `other`.
    required String titleKey,
    required HomeSectionKind kind,
    required List<HomeProductVO> products,
  }) = _HomeSectionVO;
}
