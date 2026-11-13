import 'package:donuts/features/home/domain/repositories/home_repository.dart';
import 'package:donuts/features/home/domain/usecases/watch_banners_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_home_sections_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_section_products_use_case.dart';
import 'package:donuts/features/home/domain/usecases/watch_shops_use_case.dart';
import 'package:donuts/features/home/domain/vo/banner_vo.dart';
import 'package:donuts/features/home/domain/vo/home_product_vo.dart';
import 'package:donuts/features/home/domain/vo/home_section_vo.dart';
import 'package:donuts/features/home/domain/vo/shop_vo.dart';
import 'package:donuts/features/home/presentation/blocs/home_cubit.dart';
import 'package:get_it/get_it.dart';

import 'home_fixtures.dart';

/// A Home repository that emits the seed-shaped fixtures once.
class FakeHomeRepository implements HomeRepository {
  @override
  Stream<List<BannerVO>> watchBanners() => Stream.value(testBanners);

  @override
  Stream<List<HomeSectionVO>> watchSections() => Stream.value(testHomeSections);

  @override
  Stream<List<HomeProductVO>> watchSectionProducts(String sectionId) =>
      Stream.value(testSectionProducts[sectionId] ?? const []);

  @override
  Stream<List<ShopVO>> watchShops() => Stream.value(testShops);
}

/// Fakes for the home screen's get_it dependencies, used by
/// `pumpRouterApp`. Register each one only if
/// `getIt.isRegistered<T>()` is false, so a test's own fakes win. The
/// member summary comes from `registerMemberFakes`.
void registerHomeFakes(GetIt getIt) {
  if (!getIt.isRegistered<HomeRepository>()) {
    getIt.registerSingleton<HomeRepository>(FakeHomeRepository());
  }
  if (!getIt.isRegistered<WatchBannersUseCase>()) {
    getIt.registerSingleton(WatchBannersUseCase(getIt()));
  }
  if (!getIt.isRegistered<WatchHomeSectionsUseCase>()) {
    getIt.registerSingleton(WatchHomeSectionsUseCase(getIt()));
  }
  if (!getIt.isRegistered<WatchSectionProductsUseCase>()) {
    getIt.registerSingleton(WatchSectionProductsUseCase(getIt()));
  }
  if (!getIt.isRegistered<WatchShopsUseCase>()) {
    getIt.registerSingleton(WatchShopsUseCase(getIt()));
  }
  if (!getIt.isRegistered<HomeCubit>()) {
    getIt.registerFactory(
      () => HomeCubit(
        member: getIt(),
        banners: getIt(),
        sections: getIt(),
        sectionProducts: getIt(),
        shops: getIt(),
      ),
    );
  }
}
