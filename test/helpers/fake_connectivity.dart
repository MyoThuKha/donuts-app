import 'dart:async';

import 'package:donuts/core/network/connectivity_source.dart';
import 'package:donuts/core/network/reachability_probe.dart';

/// A connectivity source the test drives by hand.
class FakeConnectivitySource implements ConnectivitySource {
  new({this.interfaceUp = false});

  bool interfaceUp;
  final StreamController<bool> _changes = StreamController.broadcast();

  void change({required bool interfaceUp}) {
    this.interfaceUp = interfaceUp;
    _changes.add(interfaceUp);
  }

  @override
  Stream<bool> get interfaceChanges => _changes.stream;

  @override
  Future<bool> hasInterface() async => interfaceUp;
}

/// A probe that answers [reachable] and counts its calls.
class FakeReachabilityProbe implements ReachabilityProbe {
  new({this.reachable = true});

  bool reachable;
  int calls = 0;

  @override
  Future<bool> call() async {
    calls++;
    return reachable;
  }
}
