import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/l10n/app_language.dart';
import 'package:donuts/core/l10n/language_cubit.dart';
import 'package:donuts/core/widgets/images/profile_avatar.dart';
import 'package:donuts/core/widgets/images/tier_backdrop.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_state.dart';
import 'package:donuts/features/settings/presentation/settings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/fake_language_store.dart';
import '../../helpers/fakes.dart';
import '../../helpers/member_fakes.dart';
import '../../helpers/pump_app.dart';
import '../../helpers/settings_fakes.dart';

void main() {
  setUp(() {
    registerMemberFakes(getIt);
    registerSettingsFakes(getIt);
  });
  tearDown(getIt.reset);

  testWidgets('shows the account details taken at sign-up', (tester) async {
    final session = testSessionCubit()..signedIn(testUser);
    await pumpThemed(
      tester,
      BlocProvider.value(
        value: session,
        child: SettingsScreen(
          now: () => DateTime(2026, 11, 12),
          readVersion: () async => '1.0.0',
        ),
      ),
    );
    await tester.pump();

    expect(find.text('YP'), findsOneWidget, reason: 'initials avatar');
    expect(find.text('Ye Min Phyoe Win'), findsOneWidget);
    expect(find.text('Silver member'), findsOneWidget);
    expect(find.text('+959254135592'), findsOneWidget);
    expect(find.text('May 1, 1980'), findsOneWidget);
    expect(find.text('46 years'), findsOneWidget);
    expect(find.text('J’Donuts 1.0.0'), findsOneWidget);
  });

  testWidgets('the header sits on the backdrop of the member tier, with '
      'their photo', (tester) async {
    final session = testSessionCubit()..signedIn(testUser);
    await pumpThemed(
      tester,
      BlocProvider.value(
        value: session,
        child: SettingsScreen(readVersion: () async => '1.0.0'),
      ),
    );
    await tester.pump();

    final backdrop = tester.widget<TierBackdrop>(find.byType(TierBackdrop));
    expect(backdrop.tierId, 'silver');
    final avatar = tester.widget<ProfileAvatar>(find.byType(ProfileAvatar));
    expect(avatar.imageUrl, testMemberSummary.avatarUrl);
  });

  testWidgets('pulling down stretches the blue header from the top', (
    tester,
  ) async {
    final session = testSessionCubit()..signedIn(testUser);
    await pumpThemed(
      tester,
      BlocProvider.value(
        value: session,
        child: SettingsScreen(readVersion: () async => '1.0.0'),
      ),
    );
    final header = find.byType(FlexibleSpaceBar);
    final resting = tester.getRect(header);

    final gesture = await tester.startGesture(
      tester.getCenter(find.text('Log out')),
    );
    for (var i = 0; i < 10; i++) {
      await gesture.moveBy(const Offset(0, 20));
      await tester.pump();
    }

    final pulled = tester.getRect(header);
    expect(pulled.top, resting.top);
    expect(pulled.height, greaterThan(resting.height));
    await gesture.up();
    await tester.pumpAndSettle();
  });

  testWidgets('no version line when the version cannot be read', (
    tester,
  ) async {
    final session = testSessionCubit()..signedIn(testUser);
    await pumpThemed(
      tester,
      BlocProvider.value(
        value: session,
        child: SettingsScreen(
          readVersion: () => Future.error(StateError('no platform')),
        ),
      ),
    );
    await tester.pump();

    expect(find.textContaining('J’Donuts'), findsNothing);
  });

  testWidgets('Log out, once confirmed, signs the user out', (tester) async {
    final session = testSessionCubit()..signedIn(testUser);
    await pumpThemed(
      tester,
      BlocProvider.value(
        value: session,
        child: SettingsScreen(readVersion: () async => '1.0.0'),
      ),
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
      BlocProvider.value(
        value: session,
        child: SettingsScreen(readVersion: () async => '1.0.0'),
      ),
    );

    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(session.state, SessionSignedIn(testUser));
  });

  testWidgets('picking မြန်မာ switches the app to Burmese and stores it', (
    tester,
  ) async {
    final session = testSessionCubit()..signedIn(testUser);
    final store = FakeLanguageStore();
    final language = LanguageCubit(store);
    addTearDown(language.close);
    await pumpThemed(
      tester,
      BlocProvider.value(
        value: session,
        child: SettingsScreen(readVersion: () async => '1.0.0'),
      ),
      language: language,
    );

    expect(find.text('Device language'), findsOneWidget);
    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('မြန်မာ'));
    await tester.pumpAndSettle();

    expect(language.state, AppLanguage.burmese);
    expect(store.code, 'my');
    expect(find.text('ဘာသာစကား'), findsOneWidget, reason: 'sheet closed');
    expect(find.text('မြန်မာ'), findsOneWidget, reason: 'row value');
    expect(find.text('အကောင့်မှ ထွက်ရန်'), findsOneWidget);
  });
}
