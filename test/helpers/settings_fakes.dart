import 'package:donuts/features/settings/presentation/blocs/settings_member_cubit.dart';
import 'package:get_it/get_it.dart';

import 'cart_fakes.dart';

/// The Settings header's cubit, unless a test registered its own. It reads
/// the member summary from `registerMemberFakes`, which must run first.
void registerSettingsFakes(GetIt getIt) {
  // The header's cart tag.
  registerCartFakes(getIt);
  if (!getIt.isRegistered<SettingsMemberCubit>()) {
    getIt.registerFactory(() => SettingsMemberCubit(getIt()));
  }
}
