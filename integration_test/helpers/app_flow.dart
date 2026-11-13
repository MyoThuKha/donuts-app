import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:donuts/app/app.dart';
import 'package:donuts/app/bootstrap.dart';
import 'package:donuts/app/di/di.dart';
import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/storage/language_store.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/features/auth/presentation/dob/dob_screen.dart';
import 'package:donuts/features/auth/presentation/name/name_screen.dart';
import 'package:donuts/features/auth/presentation/otp/otp_screen.dart';
import 'package:donuts/features/auth/presentation/phone/phone_screen.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../test/helpers/fake_connectivity.dart';
import '../../test/helpers/memory_session_store.dart';

/*
 Steps the device tests share. Each run starts the app on an in-memory
 database and session store, with no network, so it starts the same way
 every time.
*/

/// The fake auth's code for every number.
const String fakeOtp = '123456';

/// Real frames take real time here, so waits poll instead of settling once.
const Duration pollStep = Duration(milliseconds: 100);
const Duration waitLimit = Duration(seconds: 15);

Future<void> startApp(
  WidgetTester tester,
  MemorySessionStore sessionStore,
) async {
  await configureDependencies(
    database: AppDatabase.forTesting(NativeDatabase.memory()),
    sessionStore: sessionStore,
    // The finders read English text, whatever language the device uses or
    // the app last saved.
    languageStore: EnglishLanguageStore(),
    connectivitySource: FakeConnectivitySource(),
    probe: FakeReachabilityProbe(reachable: false),
  );
  addTearDown(getIt.reset);
  await bootstrap();
  await tester.pumpWidget(const DonutsApp());
}

Future<void> enterPhone(WidgetTester tester, String phone) async {
  await waitForScreen(tester, PhoneScreen);
  await tester.enterText(fieldsOf(PhoneScreen), phone);
  await tapPrimary(tester, PhoneScreen);
}

/// The code verifies itself once the sixth digit is in.
Future<void> enterOtp(WidgetTester tester) async {
  await waitForScreen(tester, OtpScreen);
  await tester.enterText(fieldsOf(OtpScreen), fakeOtp);
}

Future<void> enterName(WidgetTester tester) async {
  await waitForScreen(tester, NameScreen);
  await tester.enterText(fieldsOf(NameScreen).at(0), 'Ye Min');
  await tester.enterText(fieldsOf(NameScreen).at(1), 'Phyoe Win');
  await tapPrimary(tester, NameScreen);
}

/// Opens the wheel from the Month field, turns it to [date] through the
/// picker's own callback and confirms.
Future<void> pickDateOfBirth(WidgetTester tester, DateTime date) async {
  await waitForScreen(tester, DobScreen);
  await tester.tap(find.text('Month'));
  final picker = find.byType(CupertinoDatePicker);
  await waitForArrival(tester, picker);
  tester.widget<CupertinoDatePicker>(picker).onDateTimeChanged(date);
  await tester.tap(find.text('SELECT'));
  await tapPrimary(tester, DobScreen);
}

/// Scrolls the tile named [name] into view and taps it.
Future<void> openProduct(WidgetTester tester, String name) async {
  final tile = find.text(name);
  await waitFor(tester, tile);
  await tester.ensureVisible(tile);
  await tester.pump(pollStep);
  await tester.tap(tile);
}

Finder inside(Type screen, Finder finder) =>
    find.descendant(of: find.byType(screen), matching: finder);

Finder fieldsOf(Type screen) => inside(screen, find.byType(TextField));

/// Waits until [screen]'s primary button is enabled, then taps it.
Future<void> tapPrimary(WidgetTester tester, Type screen) async {
  final enabled = inside(
    screen,
    find.byWidgetPredicate(
      (widget) => widget is AppPrimaryButton && widget.onPressed != null,
    ),
  );
  await waitFor(tester, enabled);
  await tester.tap(enabled);
  await tester.pump(pollStep);
}

Future<void> waitForScreen(WidgetTester tester, Type screen) =>
    waitForArrival(tester, find.byType(screen));

/// Waits until [finder] matches and the route holding it has finished
/// arriving, so taps reach it instead of the transition.
Future<void> waitForArrival(WidgetTester tester, Finder finder) async {
  await waitFor(tester, finder);
  await waitUntil(
    tester,
    () => ModalRoute.of(tester.element(finder))!.animation!.isCompleted,
    'the route of ${finder.describeMatch(Plurality.one)} to arrive',
  );
}

Future<void> waitFor(WidgetTester tester, Finder finder) => waitUntil(
  tester,
  () => finder.evaluate().isNotEmpty,
  finder.describeMatch(Plurality.zero),
);

/// Pumps frames until [done] is true, or fails after [waitLimit].
Future<void> waitUntil(
  WidgetTester tester,
  bool Function() done,
  String what,
) async {
  final end = DateTime.now().add(waitLimit);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(pollStep);
    if (done()) return;
  }
  fail('Timed out waiting for $what');
}

/// Always reads English. Bootstrap clears a saved language on a new install,
/// and the in-memory database makes every run a new install.
class EnglishLanguageStore implements LanguageStore {
  @override
  Future<String?> readCode() async => 'en';

  @override
  Future<void> writeCode(String? code) async {}
}
