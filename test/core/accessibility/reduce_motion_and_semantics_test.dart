import 'package:cached_network_image/cached_network_image.dart';
import 'package:donuts/core/l10n/app_language.dart';
import 'package:donuts/core/l10n/language_cubit.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/theme/app_theme.dart';
import 'package:donuts/core/widgets/images/network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../helpers/fake_language_store.dart';
import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';

void _reduceMotion(WidgetTester tester) {
  tester.platformDispatcher.accessibilityFeaturesTestValue =
      const FakeAccessibilityFeatures(disableAnimations: true);
  addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);
}

/// Opens a plain page from a button, on iOS, with the app theme.
Future<void> _pushPage(WidgetTester tester) async {
  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  addTearDown(() => debugDefaultTargetPlatformOverride = null);
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      home: Builder(
        builder: (context) => TextButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute<void>(builder: (_) => const Text('Next page')),
          ),
          child: const Text('Open'),
        ),
      ),
    ),
  );
  await tester.tap(find.text('Open'));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
}

/// Whether a SlideTransition above [finder] is mid-slide.
bool _sliding(WidgetTester tester, Finder finder) => tester
    .widgetList<SlideTransition>(
      find.ancestor(of: finder, matching: find.byType(SlideTransition)),
    )
    .any((slide) => slide.position.value != Offset.zero);

void main() {
  group('Reduce Motion', () {
    testWidgets('pages slide in when motion is on', (tester) async {
      await _pushPage(tester);

      expect(_sliding(tester, find.text('Next page')), isTrue);
      await tester.pumpAndSettle();
    });

    testWidgets('pages fade in without sliding when it is off', (tester) async {
      _reduceMotion(tester);
      await _pushPage(tester);

      expect(_sliding(tester, find.text('Next page')), isFalse);
      expect(
        find.ancestor(
          of: find.text('Next page'),
          matching: find.byType(FadeTransition),
        ),
        findsWidgets,
      );
      await tester.pumpAndSettle();
    });

    testWidgets('photos appear without a fade', (tester) async {
      _reduceMotion(tester);
      await pumpThemed(
        tester,
        const AppNetworkImage(url: 'https://example.com/donut.webp'),
      );

      final image = tester.widget<CachedNetworkImage>(
        find.byType(CachedNetworkImage),
      );
      expect(image.fadeInDuration, Duration.zero);
      expect(image.fadeOutDuration, Duration.zero);
    });

    testWidgets('product images skip the Hero flight', (tester) async {
      _reduceMotion(tester);
      await pumpRouterApp(
        tester,
        session: testSessionCubit()..signedIn(testUser),
        initialLocation: AppRoutes.productDetail('p_coconut'),
      );

      final modes = tester.widgetList<HeroMode>(find.byType(HeroMode));
      expect(modes, isNotEmpty);
      expect(modes.every((mode) => !mode.enabled), isTrue);
    });
  });

  group('screen reader language', () {
    testWidgets('a picked language reaches the screen reader', (tester) async {
      final handle = tester.ensureSemantics();
      await pumpRouterApp(
        tester,
        session: testSessionCubit()..signedIn(testUser),
        initialLocation: AppRoutes.settings,
        language: AppLanguage.burmese,
      );

      final row = tester.getSemantics(find.text('ဘာသာစကား'));
      expect(row.getSemanticsData().locale, const Locale('my'));
      handle.dispose();
    });

    testWidgets('each language option is read in its own language', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await pumpRouterApp(
        tester,
        session: testSessionCubit()..signedIn(testUser),
        initialLocation: AppRoutes.settings,
        language: AppLanguage.burmese,
      );
      await tester.tap(find.text('ဘာသာစကား'));
      await tester.pumpAndSettle();

      Locale? localeOf(String text) =>
          tester.getSemantics(find.text(text).last).getSemanticsData().locale;
      expect(localeOf('English'), const Locale('en'));
      expect(localeOf('မြန်မာ'), const Locale('my'));
      handle.dispose();
    });

    testWidgets('switching language keeps the page and its state', (
      tester,
    ) async {
      final language = LanguageCubit(FakeLanguageStore());
      addTearDown(language.close);
      await pumpThemed(tester, const _Counter(), language: language);
      await tester.tap(find.text('0'));
      await tester.pump();

      await language.select(AppLanguage.burmese);
      await tester.pump();

      expect(find.text('1'), findsOneWidget, reason: 'state survived');
      expect(
        tester.element(find.text('1')).read<LanguageCubit>().state,
        AppLanguage.burmese,
      );
    });
  });
}

/// Counts taps, to show its state survives a language switch.
class _Counter extends StatefulWidget {
  const new();

  @override
  State<_Counter> createState() => _CounterState();
}

class _CounterState extends State<_Counter> {
  int _taps = 0;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => setState(() => _taps++),
    child: Text('$_taps'),
  );
}
