import 'package:donuts/app/bootstrap.dart';
import 'package:donuts/app/di/di.dart';
import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/domain/usecases/log_out_use_case.dart';
import 'package:donuts/features/cart/domain/params/add_to_cart_params.dart';
import 'package:donuts/features/cart/domain/usecases/add_to_cart_use_case.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_connectivity.dart';
import '../../helpers/fake_language_store.dart';
import '../../helpers/file_seed_source.dart';
import '../../helpers/memory_session_store.dart';

void main() {
  tearDown(getIt.reset);

  test("the app's log out empties the cart", () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    await configureDependencies(
      database: db,
      sessionStore: MemorySessionStore(),
      languageStore: FakeLanguageStore(),
      authLatency: Duration.zero,
      seedSource: FileSeedSource(),
      connectivitySource: FakeConnectivitySource(),
      probe: FakeReachabilityProbe(),
    );
    await bootstrap();
    await getIt<AddToCartUseCase>()(
      const AddToCartParams(productId: 'p_coconut', quantity: 2),
    );

    final result = await getIt<LogOutUseCase>()();

    expect(result, isA<Success<void>>());
    expect(await db.cartDao.quantityOf('p_coconut'), isNull);
  });
}
