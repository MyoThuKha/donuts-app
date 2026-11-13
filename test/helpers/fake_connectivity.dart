import 'dart:async';

import 'package:donuts/core/network/connectivity_cubit.dart';
import 'package:donuts/core/network/connectivity_source.dart';
import 'package:donuts/core/network/reachability_probe.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

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

/// A [ConnectivityCubit] over the fakes, closed when the test ends. The
/// source has no network, so [ConnectivityCubit.start] turns it offline.
ConnectivityCubit testConnectivity() {
  final cubit = ConnectivityCubit(
    FakeConnectivitySource(),
    FakeReachabilityProbe(),
  );
  addTearDown(cubit.close);
  return cubit;
}

/// A `MaterialApp.builder` that provides [cubit] above the navigator, for
/// screens that show the offline banner.
TransitionBuilder provideConnectivity(ConnectivityCubit cubit) =>
    (context, child) => BlocProvider.value(value: cubit, child: child);
