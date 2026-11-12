import 'package:get_it/get_it.dart';

/// Fakes for the product screen's get_it dependencies, used by
/// `pumpRouterApp`. Register each one only if
/// `getIt.isRegistered<T>()` is false, so a test's own fakes win.
void registerProductFakes(GetIt getIt) {}
