import 'dart:async';

import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:material_ui/material_ui.dart';

/// Tells go_router to re-run its redirect whenever the session changes.
class SessionListenable extends ChangeNotifier {
  new(SessionCubit session) {
    _subscription = session.stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<Object?> _subscription;

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}
