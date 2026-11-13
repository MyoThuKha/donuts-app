import 'package:donuts/features/settings/presentation/blocs/settings_member_cubit.dart';
import 'package:get_it/get_it.dart';

/// The Settings header's cubit. It reads the member summary that
/// `registerRewardsModule` registers.
void registerSettingsModule(GetIt getIt) {
  getIt.registerFactory(() => SettingsMemberCubit(getIt()));
}
