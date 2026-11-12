import 'dart:async';

import 'package:donuts/core/network/connectivity_source.dart';
import 'package:donuts/core/network/reachability_probe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ConnectivityStatus { unknown, online, offline }

/// Online means an interface is up and the API host answers.
///
/// While an interface is up but the host doesn't answer (hotel Wi-Fi, a
/// captive portal), it probes again every [reprobeInterval].
class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  new(
    this._source,
    this._probe, {
    this.reprobeInterval = defaultReprobeInterval,
  }) : super(ConnectivityStatus.unknown);

  static const Duration defaultReprobeInterval = Duration(seconds: 15);

  final ConnectivitySource _source;
  final ReachabilityProbe _probe;
  final Duration reprobeInterval;
  StreamSubscription<bool>? _subscription;
  Timer? _reprobeTimer;

  /// Bumped on every interface change, so a slow probe from before the
  /// change can't overwrite the newer status.
  int _generation = 0;

  /// Checks once, then follows interface changes.
  Future<void> start() async {
    _subscription ??= _source.interfaceChanges.listen(_onInterface);
    await _onInterface(await _source.hasInterface());
  }

  Future<void> _onInterface(bool interfaceUp) async {
    _stopReprobing();
    final generation = ++_generation;
    if (!interfaceUp) return _set(ConnectivityStatus.offline);

    await _probeOnce(generation);
    if (state == ConnectivityStatus.offline && generation == _generation) {
      _reprobeTimer = Timer.periodic(
        reprobeInterval,
        (_) => _probeOnce(generation),
      );
    }
  }

  Future<void> _probeOnce(int generation) async {
    final reachable = await _probe();
    if (generation != _generation) return;
    if (reachable) _stopReprobing();
    _set(reachable ? ConnectivityStatus.online : ConnectivityStatus.offline);
  }

  void _set(ConnectivityStatus status) {
    if (!isClosed) emit(status);
  }

  void _stopReprobing() {
    _reprobeTimer?.cancel();
    _reprobeTimer = null;
  }

  @override
  Future<void> close() async {
    _stopReprobing();
    await _subscription?.cancel();
    await super.close();
  }
}
