import 'package:donuts/app/di/product_module.dart';
import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/features/product/presentation/blocs/product_detail_cubit.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  test('registerProductModule builds a new cubit per product id', () async {
    final getIt = GetIt.asNewInstance();
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    getIt
      ..registerSingleton(db)
      ..registerSingleton<DateTime Function()>(DateTime.now);
    registerProductModule(getIt);

    final first = getIt<ProductDetailCubit>(param1: 'p_coconut');
    final second = getIt<ProductDetailCubit>(param1: 'p_coconut');

    expect(first, isNot(same(second)));
    await first.close();
    await second.close();
    await db.close();
  });
}
