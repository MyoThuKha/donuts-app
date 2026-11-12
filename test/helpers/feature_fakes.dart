import 'package:get_it/get_it.dart';

import 'home_fakes.dart';
import 'product_fakes.dart';
import 'rewards_fakes.dart';

/// Registers fakes for every feature screen's dependencies, so router and
/// shell tests can build the real screens. Each feature fills only its own
/// helper, and each helper skips anything a test already registered.
void registerFeatureFakes(GetIt getIt) {
  registerHomeFakes(getIt);
  registerProductFakes(getIt);
  registerRewardsFakes(getIt);
}
