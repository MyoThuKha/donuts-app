import 'dart:async';

import 'package:material_ui/material_ui.dart';

/// Lets a control ignore taps while the work an earlier tap started is
/// still running, so a double tap can't send a request twice or open the
/// same screen twice.
///
/// A tap that opens a screen returns `context.push(...)`, whose future
/// completes when that screen pops, so the control works again once the
/// user comes back.
mixin PendingTapGuard<T extends StatefulWidget> on State<T> {
  bool _pending = false;

  /// Runs [action] unless an earlier one is still running. A synchronous
  /// [action] never blocks the next tap.
  void runGuarded(FutureOr<void> Function() action) {
    if (_pending) return;
    final result = action();
    if (result is Future<void>) unawaited(_holdUntil(result));
  }

  /// The future's error still reaches the zone, as it would unguarded.
  Future<void> _holdUntil(Future<void> work) async {
    _pending = true;
    try {
      await work;
    } finally {
      _pending = false;
    }
  }
}
