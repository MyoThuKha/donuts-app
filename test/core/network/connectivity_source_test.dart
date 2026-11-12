import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:donuts/core/network/connectivity_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockConnectivity extends Mock implements Connectivity;

void main() {
  test('a transport change between two live interfaces is still reported, '
      'so the cubit probes again', () async {
    final connectivity = _MockConnectivity();
    when(() => connectivity.onConnectivityChanged).thenAnswer(
      (_) => Stream.fromIterable([
        [ConnectivityResult.mobile],
        [ConnectivityResult.wifi],
        [ConnectivityResult.none],
      ]),
    );

    final changes = await PlusConnectivitySource(connectivity).interfaceChanges
        .toList();

    expect(changes, [true, true, false]);
  });
}
