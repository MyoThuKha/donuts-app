import 'package:connectivity_plus/connectivity_plus.dart';

/// Whether the device has any network interface up. An interface doesn't
/// mean the internet is reachable; `ReachabilityProbe` checks that.
abstract interface class ConnectivitySource {
  Stream<bool> get interfaceChanges;

  Future<bool> hasInterface();
}

class PlusConnectivitySource implements ConnectivitySource {
  const new(this._connectivity);

  final Connectivity _connectivity;

  @override
  Stream<bool> get interfaceChanges =>
      _connectivity.onConnectivityChanged.map(_anyUp).distinct();

  @override
  Future<bool> hasInterface() async =>
      _anyUp(await _connectivity.checkConnectivity());

  static bool _anyUp(List<ConnectivityResult> results) =>
      results.any((r) => r != ConnectivityResult.none);
}
