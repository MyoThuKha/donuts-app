import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:donuts/core/network/connectivity_cubit.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_connectivity.dart';

void main() {
  late FakeConnectivitySource source;
  late FakeReachabilityProbe probe;

  ConnectivityCubit build() => ConnectivityCubit(source, probe);

  setUp(() {
    source = FakeConnectivitySource();
    probe = FakeReachabilityProbe();
  });

  test('starts unknown', () {
    expect(build().state, ConnectivityStatus.unknown);
  });

  blocTest<ConnectivityCubit, ConnectivityStatus>(
    'start with no interface emits offline without probing',
    build: build,
    act: (cubit) => cubit.start(),
    expect: () => [ConnectivityStatus.offline],
    verify: (_) => expect(probe.calls, 0),
  );

  blocTest<ConnectivityCubit, ConnectivityStatus>(
    'start with an interface and a good probe emits online',
    setUp: () => source.interfaceUp = true,
    build: build,
    act: (cubit) => cubit.start(),
    expect: () => [ConnectivityStatus.online],
  );

  blocTest<ConnectivityCubit, ConnectivityStatus>(
    'losing the interface emits offline',
    setUp: () => source.interfaceUp = true,
    build: build,
    act: (cubit) async {
      await cubit.start();
      source.change(interfaceUp: false);
    },
    expect: () => [ConnectivityStatus.online, ConnectivityStatus.offline],
  );

  blocTest<ConnectivityCubit, ConnectivityStatus>(
    'an interface coming back with a good probe emits online',
    build: build,
    act: (cubit) async {
      await cubit.start();
      source.change(interfaceUp: true);
    },
    expect: () => [ConnectivityStatus.offline, ConnectivityStatus.online],
  );

  test('stays offline while the probe fails and goes online when a re-probe '
      'succeeds', () {
    fakeAsync((async) {
      source.interfaceUp = true;
      probe.reachable = false;
      final cubit = build();
      unawaited(cubit.start());
      async.flushMicrotasks();
      expect(cubit.state, ConnectivityStatus.offline);

      async.elapse(ConnectivityCubit.defaultReprobeInterval);
      expect(cubit.state, ConnectivityStatus.offline);
      expect(probe.calls, 2);

      probe.reachable = true;
      async.elapse(ConnectivityCubit.defaultReprobeInterval);
      expect(cubit.state, ConnectivityStatus.online);
      unawaited(cubit.close());
    });
  });

  test('recheck while online goes offline when the host stops answering, '
      'then re-probes', () {
    fakeAsync((async) {
      source.interfaceUp = true;
      final cubit = build();
      unawaited(cubit.start());
      async.flushMicrotasks();
      expect(cubit.state, ConnectivityStatus.online);

      probe.reachable = false;
      unawaited(cubit.recheck());
      async.flushMicrotasks();
      expect(cubit.state, ConnectivityStatus.offline);

      probe.reachable = true;
      async.elapse(ConnectivityCubit.defaultReprobeInterval);
      expect(cubit.state, ConnectivityStatus.online);
      unawaited(cubit.close());
    });
  });

  test('close cancels the re-probe timer', () {
    fakeAsync((async) {
      source.interfaceUp = true;
      probe.reachable = false;
      final cubit = build();
      unawaited(cubit.start());
      async.flushMicrotasks();
      unawaited(cubit.close());
      final callsAtClose = probe.calls;

      async.elapse(ConnectivityCubit.defaultReprobeInterval * 3);

      expect(probe.calls, callsAtClose);
    });
  });
}
