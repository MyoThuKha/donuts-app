import 'package:donuts/features/home/domain/types/banner_style.dart';
import 'package:donuts/features/home/domain/vo/banner_vo.dart';
import 'package:donuts/features/home/domain/vo/home_product_vo.dart';
import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:donuts/features/home/domain/vo/shop_vo.dart';

/// Home content shaped like the seed catalog, without image assets so
/// widget tests never load a file.
const String _imageBase = 'https://example.com/images';

HomeProductVO _product(String id, String name, {int? discountPercent}) =>
    HomeProductVO(
      id: id,
      name: name,
      discountPercent: discountPercent,
      imageUrl: '$_imageBase/$id.webp',
    );

final HomeProductVO _dalgona = _product('p_dalgona', 'Dalgona Creamy Coffee');

final List<BannerVO> testBanners = [
  const BannerVO(
    id: 'b_central_boulevard',
    tag: 'New shop',
    title: 'We are now at Central Boulevard',
    style: BannerStyle.indigo,
    imageUrl: '$_imageBase/b_central_boulevard.webp',
  ),
  const BannerVO(
    id: 'b_hot_drinks',
    tag: '50% off',
    title: 'Hot drinks are here',
    style: BannerStyle.sky,
    imageUrl: '$_imageBase/b_hot_drinks.webp',
  ),
];

const List<HomeSectionVO> testHomeSections = [
  HomeSectionVO(
    id: 'seasonal',
    titleKey: 'seasonal',
    kind: HomeSectionKind.seasonal,
  ),
  HomeSectionVO(
    id: 'popular',
    titleKey: 'popular',
    kind: HomeSectionKind.popular,
  ),
  HomeSectionVO(
    id: 'order_again',
    titleKey: 'order_again',
    kind: HomeSectionKind.orderAgain,
  ),
];

/// Each of [testHomeSections]' products, by row id.
final Map<String, List<HomeProductVO>> testSectionProducts = {
  'seasonal': [
    _product('p_mistletoe_box', 'Mistletoe Romance box', discountPercent: 50),
    _product('p_christmas_family_box', 'Christmas Mix Family box'),
  ],
  'popular': [
    _product('p_strawberry_chocolate', 'Strawberry Chocolate Donuts'),
    _dalgona,
    _product('p_coconut', 'Coconut Donut'),
    _product('p_blueberry', 'Blueberry Glazed Donut'),
  ],
  'order_again': [
    _product(
      'p_santa_cookies',
      "Santa's favorite cookies set",
      discountPercent: 20,
    ),
    _product('p_caramel_crunch', 'Caramel Crunch Donut', discountPercent: 20),
    _dalgona,
  ],
};

final List<ShopVO> testShops = [
  for (final (i, name) in [
    'Myaynigone',
    'Sanchaung',
    'Downtown',
    'Central Boulevard',
  ].indexed)
    ShopVO(
      id: 's_$i',
      name: 'J’Donuts $name',
      address: 'Yangon',
      imageUrl: '$_imageBase/s_$i.webp',
    ),
];
