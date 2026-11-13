import 'package:donuts/core/theme/donuts_colors.dart';
import 'package:donuts/core/widgets/feedback/app_snack_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

void main() {
  Future<void> show(WidgetTester tester, AppSnackBarTone tone) async {
    await pumpThemed(
      tester,
      Builder(
        builder: (context) => TextButton(
          onPressed: () => context.showMessage('Hello', tone: tone),
          child: const Text('show'),
        ),
      ),
    );
    await tester.tap(find.text('show'));
    await tester.pumpAndSettle();
  }

  BoxDecoration badgeOf(WidgetTester tester) =>
      tester
              .widget<DecoratedBox>(
                find
                    .ancestor(
                      of: find.byType(Icon),
                      matching: find.byType(DecoratedBox),
                    )
                    .first,
              )
              .decoration
          as BoxDecoration;

  for (final (tone, icon, color) in [
    (AppSnackBarTone.info, LucideIcons.info, DonutsColors.light.primary),
    (AppSnackBarTone.success, LucideIcons.check, DonutsColors.light.success),
    (AppSnackBarTone.error, LucideIcons.x, DonutsColors.light.danger),
  ]) {
    testWidgets('a ${tone.name} message shows its badge', (tester) async {
      await show(tester, tone);

      expect(find.text('Hello'), findsOneWidget);
      expect(find.byIcon(icon), findsOneWidget);
      expect(badgeOf(tester).color, color);
    });
  }

  testWidgets('a new message replaces the one on screen', (tester) async {
    await pumpThemed(
      tester,
      Builder(
        builder: (context) => Column(
          children: [
            TextButton(
              onPressed: () => context.showMessage('First'),
              child: const Text('first'),
            ),
            TextButton(
              onPressed: () => context.showMessage('Second'),
              child: const Text('second'),
            ),
          ],
        ),
      ),
    );
    await tester.tap(find.text('first'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('second'));
    await tester.pumpAndSettle();

    expect(find.text('First'), findsNothing);
    expect(find.text('Second'), findsOneWidget);
  });

  testWidgets('an action shows its label, runs once and closes the snackbar', (
    tester,
  ) async {
    var undone = 0;
    await pumpThemed(
      tester,
      Builder(
        builder: (context) => TextButton(
          onPressed: () => context.showMessage(
            'Coconut Donut removed',
            action: AppSnackBarAction(label: 'Undo', onPressed: () => undone++),
          ),
          child: const Text('show'),
        ),
      ),
    );
    await tester.tap(find.text('show'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();

    expect(undone, 1);
    expect(find.text('Coconut Donut removed'), findsNothing);
  });
}
