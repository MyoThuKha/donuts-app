import 'package:get_it/get_it.dart';

import 'home_fakes.dart';
import 'member_fakes.dart';
import 'product_fakes.dart';
import 'rewards_fakes.dart';
import 'settings_fakes.dart';

/// Registers fakes for every feature screen's dependencies, so router and
/// shell tests can build the real screens. Each feature fills only its own
/// helper, and each helper skips anything a test already registered.
/// The member summary goes first: Home, Rewards and Settings read it, and 3b
/// owns it, so none of them registers its own.
void registerFeatureFakes(GetIt getIt) {
  registerMemberFakes(getIt);
  registerHomeFakes(getIt);
  registerProductFakes(getIt);
  registerRewardsFakes(getIt);
  registerSettingsFakes(getIt);
}
