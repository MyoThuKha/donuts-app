import 'package:donuts/features/auth/presentation/session/blocs/session_state.dart';
import 'package:donuts/features/settings/presentation/settings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void main() {
  testWidgets('Log out, once confirmed, signs the user out', (tester) async {
    final session = testSessionCubit()..signedIn(testUser);
    await pumpThemed(
      tester,
      BlocProvider.value(value: session, child: const SettingsScreen()),
    );

    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Log out').last);
    await tester.pumpAndSettle();

    expect(session.state, const SessionSignedOut());
  });

  testWidgets('cancelling the confirmation keeps the user signed in', (
    tester,
  ) async {
    final session = testSessionCubit()..signedIn(testUser);
    await pumpThemed(
      tester,
      BlocProvider.value(value: session, child: const SettingsScreen()),
    );

    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(session.state, SessionSignedIn(testUser));
  });
}
