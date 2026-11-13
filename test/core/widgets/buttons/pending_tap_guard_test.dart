import 'dart:async';

import 'package:donuts/core/widgets/buttons/pending_tap_guard.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

class _Host extends StatefulWidget {
  const new();

  @override
  State<_Host> createState() => _HostState();
}

class _HostState extends State<_Host> with PendingTapGuard {
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

void main() {
  late _HostState guard;

  Future<void> pumpHost(WidgetTester tester) async {
    await tester.pumpWidget(const _Host());
    guard = tester.state<_HostState>(find.byType(_Host));
  }

  testWidgets('a failed action frees the guard and its error still '
      'reaches the zone', (tester) async {
    await pumpHost(tester);
    final errors = <Object>[];
    var runs = 0;
    Future<void> failing() async {
      runs++;
      throw StateError('offline');
    }

    await runZonedGuarded(() async {
      guard.runGuarded(failing);
      await tester.pump();
    }, (error, _) => errors.add(error));
    await runZonedGuarded(() async {
      guard.runGuarded(failing);
      await tester.pump();
    }, (error, _) => errors.add(error));

    expect(runs, 2);
    expect(errors, [isA<StateError>(), isA<StateError>()]);
  });

  testWidgets('an action that is still running blocks the next one', (
    tester,
  ) async {
    await pumpHost(tester);
    final pending = Completer<void>();
    var runs = 0;

    guard
      ..runGuarded(() {
        runs++;
        return pending.future;
      })
      ..runGuarded(() => runs++);
    expect(runs, 1);

    pending.complete();
    await tester.pump();
    guard.runGuarded(() => runs++);
    expect(runs, 2);
  });
}
