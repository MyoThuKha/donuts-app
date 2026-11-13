import 'package:donuts/features/home/domain/repositories/home_repository.dart';
import 'package:donuts/features/home/domain/types/banner_style.dart';
import 'package:donuts/features/home/domain/usecases/watch_banners_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_home_sections_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_section_products_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_shops_use_case.dart';
import 'package:donuts/features/home/domain/vo/banner_vo.dart';
import 'package:donuts/features/home/domain/vo/home_product_vo.dart';
import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:donuts/features/home/domain/vo/shop_vo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepository extends Mock implements HomeRepository;

void main() {
  late _MockRepository repository;

  setUp(() => repository = _MockRepository());

  test('WatchBannersUseCase forwards the repository stream', () async {
    const banner = BannerVO(
      id: 'b1',
      tag: 'New',
      title: 'Hello',
      style: BannerStyle.indigo,
      imageUrl: 'https://example.com/b1.webp',
    );
    when(repository.watchBanners).thenAnswer((_) => Stream.value([banner]));

    expect(await WatchBannersUseCase(repository)().first, [banner]);
  });

  test('WatchHomeSectionsUseCase forwards the repository stream', () async {
    const section = HomeSectionVO(
      id: 'popular',
      titleKey: 'popular',
      kind: HomeSectionKind.popular,
    );
    when(repository.watchSections).thenAnswer((_) => Stream.value([section]));

    expect(await WatchHomeSectionsUseCase(repository)().first, [section]);
  });

  test("WatchSectionProductsUseCase forwards the row's products", () async {
    const product = HomeProductVO(
      id: 'p_coconut',
      name: 'Coconut Donut',
      imageUrl: 'https://example.com/p_coconut.webp',
    );
    when(() => repository.watchSectionProducts('popular'))
        .thenAnswer((_) => Stream.value([product]));

    expect(await WatchSectionProductsUseCase(repository)('popular').first, [
      product,
    ]);
  });

  test('WatchShopsUseCase forwards the repository stream', () async {
    const shop = ShopVO(
      id: 's1',
      name: 'Shop',
      address: 'Yangon',
      imageUrl: 'https://example.com/s1.webp',
    );
    when(repository.watchShops).thenAnswer((_) => Stream.value([shop]));

    expect(await WatchShopsUseCase(repository)().first, [shop]);
  });
}
