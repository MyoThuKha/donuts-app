import 'package:donuts/app/shell/widgets/nav_icons.dart';
import 'package:donuts/core/l10n/app_language.dart';
import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/core/result/result.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/app_fonts.dart';
import '../../helpers/auth_flow.dart';
import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

/// The PDF's smallest phone (4.7 inches, 375 by 667) at its largest text
/// scale (1.3), in Burmese, with the real fonts loaded.
void _smallPhoneLargeText(WidgetTester tester) {
  tester.view
    ..physicalSize = const Size(750, 1334)
    ..devicePixelRatio = 2;
  tester.platformDispatcher.textScaleFactorTestValue = 1.3;
  addTearDown(tester.view.reset);
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
}

Future<void> _pumpBurmese(
  WidgetTester tester, {
  required bool signedIn,
  String initialLocation = AppRoutes.home,
}) async {
  _smallPhoneLargeText(tester);
  final session = testSessionCubit();
  if (signedIn) session.signedIn(testUser);
  await pumpRouterApp(
    tester,
    session: session,
    initialLocation: initialLocation,
    language: AppLanguage.burmese,
  );
}

/// Fails with [where] when the last frames reported an overflow or any
/// other layout error.
void _expectClean(WidgetTester tester, String where) {
  final error = tester.takeException();
  // FlutterError's deep string names the widget that overflowed.
  final detail = error is FlutterError ? error.toStringDeep() : '$error';
  expect(error, isNull, reason: '$where\n$detail');
}

/// Drags the outermost scrollable to its end, checking each step.
Future<void> _scrollThrough(WidgetTester tester, String where) async {
  for (var i = 0; i < 8; i++) {
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -400));
    await tester.pumpAndSettle();
    _expectClean(tester, '$where, scrolled ${i + 1}');
  }
}

Future<void> _openTab(WidgetTester tester, String icon) async {
  await tester.tap(find.byKey(ValueKey(icon)));
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() async {
    registerAuthFallbacks();
    await loadAppFonts();
  });

  test('measures Burmese with the real font, not the test font', () {
    // The test font draws each code unit as a 1 em square: 4 units, 80 px.
    final painter = TextPainter(
      text: const TextSpan(
        text: 'ပင်မ',
        style: TextStyle(
          fontFamily: 'SchibstedGrotesk',
          fontFamilyFallback: ['NotoSansMyanmar'],
          fontSize: 20,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    addTearDown(painter.dispose);

    expect(painter.width, lessThan(70));
  });

  group('signed in', () {
    testWidgets('Home', (tester) async {
      await _pumpBurmese(tester, signedIn: true);
      expect(find.text('ပင်မ'), findsOneWidget);
      _expectClean(tester, 'Home');
      await _scrollThrough(tester, 'Home');
    });

    testWidgets('every tab', (tester) async {
      await _pumpBurmese(tester, signedIn: true);
      for (final icon in [
        NavIcons.reward,
        NavIcons.explore,
        NavIcons.wallet,
        NavIcons.settings,
        NavIcons.home,
      ]) {
        await _openTab(tester, icon);
        _expectClean(tester, 'tab $icon');
      }
    });

    testWidgets('Rewards, both lists', (tester) async {
      await _pumpBurmese(tester, signedIn: true);
      await _openTab(tester, NavIcons.reward);
      _expectClean(tester, 'Rewards');
      await _scrollThrough(tester, 'Rewards challenges');

      await tester.drag(find.byType(Scrollable).first, const Offset(0, 4000));
      await tester.pumpAndSettle();
      await tester.tap(find.text('လက်ဆောင်'));
      await tester.pumpAndSettle();
      _expectClean(tester, 'Rewards gifts');
      await _scrollThrough(tester, 'Rewards gifts');
    });

    testWidgets('Settings, the language sheet and Log out', (tester) async {
      await _pumpBurmese(tester, signedIn: true);
      await _openTab(tester, NavIcons.settings);
      _expectClean(tester, 'Settings');

      await tester.tap(find.text('ဘာသာစကား'));
      await tester.pumpAndSettle();
      _expectClean(tester, 'language sheet');
      await tester.tap(find.text('မြန်မာ').last);
      await tester.pumpAndSettle();

      await tester.tap(find.text('အကောင့်မှ ထွက်ရန်'));
      await tester.pumpAndSettle();
      _expectClean(tester, 'Log out dialog');
      await tester.tap(find.text('မလုပ်တော့ပါ'));
      await tester.pumpAndSettle();
    });

    testWidgets('Welcome', (tester) async {
      await _pumpBurmese(
        tester,
        signedIn: true,
        initialLocation: AppRoutes.welcome,
      );
      _expectClean(tester, 'Welcome');
    });

    testWidgets('Product detail and its snackbar', (tester) async {
      await _pumpBurmese(
        tester,
        signedIn: true,
        initialLocation: AppRoutes.productDetail('p_coconut'),
      );
      _expectClean(tester, 'Product detail');
      await tester.ensureVisible(find.text('ခြင်းထဲ ထည့်ရန်'));
      await tester.tap(find.text('ခြင်းထဲ ထည့်ရန်'));
      await tester.pump(const Duration(milliseconds: 500));
      _expectClean(tester, 'added-to-cart snackbar');
      await tester.pumpAndSettle(const Duration(seconds: 5));
      await _scrollThrough(tester, 'Product detail');
    });
  });

  group('signed out', () {
    late AuthFlowMocks mocks;

    setUp(() async {
      mocks = AuthFlowMocks();
      await mocks.install();
      when(() => mocks.verifyOtp(any()))
          .thenAnswer((_) async => const Failure(WrongOtpFailure()));
    });

    tearDown(() => FocusManager.instance.primaryFocus?.unfocus());

    testWidgets('Onboarding', (tester) async {
      await _pumpBurmese(
        tester,
        signedIn: false,
        initialLocation: AppRoutes.onboarding,
      );
      _expectClean(tester, 'Onboarding');
      await unmountApp(tester);
    });

    testWidgets('phone and OTP, with their error messages', (tester) async {
      await _pumpBurmese(
        tester,
        signedIn: false,
        initialLocation: AppRoutes.logInPhone,
      );
      _expectClean(tester, 'phone');
      await tester.enterText(find.byType(TextField), '0912');
      await tester.pumpAndSettle();
      _expectClean(tester, 'phone error');

      await tester.enterText(find.byType(TextField), '09254135592');
      await tester.pump();
      await tester.tap(find.byType(AppPrimaryButton));
      await tester.pumpAndSettle();
      _expectClean(tester, 'OTP');
      await tester.enterText(find.byType(TextField), '000000');
      await tester.pumpAndSettle();
      _expectClean(tester, 'OTP wrong code');
      await unmountApp(tester);
    });

    testWidgets('name and date of birth', (tester) async {
      await _pumpBurmese(
        tester,
        signedIn: false,
        initialLocation: AppRoutes.registerName,
      );
      _expectClean(tester, 'name');
      await tester.enterText(find.byType(TextField).first, '1');
      await tester.pumpAndSettle();
      _expectClean(tester, 'name error');

      await tester.enterText(find.byType(TextField).first, 'ရဲမင်း');
      await tester.pump();
      await tester.tap(find.byType(AppPrimaryButton));
      await tester.pumpAndSettle();
      _expectClean(tester, 'date of birth');

      await tester.tap(find.text('လ'));
      await tester.pumpAndSettle();
      expect(find.text('သင့်မွေးနေ့ကို ရွေးပါ'), findsOneWidget);
      _expectClean(tester, 'date of birth wheel');
      await unmountApp(tester);
    });
  });
}
