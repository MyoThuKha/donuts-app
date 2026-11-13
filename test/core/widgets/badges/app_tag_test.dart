import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/widgets/badges/app_tag.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

ShapeBorder _shapeOf(WidgetTester tester) {
  final box = tester.widget<DecoratedBox>(
    find.descendant(
      of: find.byType(AppTag),
      matching: find.byType(DecoratedBox),
    ),
  );
  return (box.decoration as ShapeDecoration).shape;
}

void main() {
  test('an enclosing radius is the inner radius plus the inset', () {
    expect(AppRadii.enclosing(14.5, 8), 22.5);
  });

  test('a concentric radius is the outer radius less the inset', () {
    expect(AppRadii.concentric(20, 8), 12);
  });

  test('a concentric radius stops at its minimum', () {
    expect(AppRadii.concentric(20, 20, minimum: 12), 12);
  });

  testWidgets('a cornered badge is a rounded rectangle with a white rim', (
    tester,
  ) async {
    await pumpThemed(
      tester,
      const Center(child: AppTag(label: '50% off', cornerRadius: 4)),
    );

    final shape = _shapeOf(tester) as RoundedRectangleBorder;
    expect(shape.borderRadius, BorderRadius.circular(4));
    expect(shape.side.color, Colors.white);
    expect(shape.side.width, AppSizes.rim);
  });

  testWidgets('without a corner radius the badge is a pill', (tester) async {
    await pumpThemed(tester, const Center(child: AppTag(label: '50% off')));

    expect(_shapeOf(tester), isA<StadiumBorder>());
  });

  testWidgets('heightOf matches the laid-out pill, at large text too', (
    tester,
  ) async {
    for (final scale in [1.0, 2.0]) {
      late double predicted;
      await pumpThemed(
        tester,
        MediaQuery(
          data: MediaQueryData(textScaler: TextScaler.linear(scale)),
          child: Center(
            child: Builder(
              builder: (context) {
                predicted = AppTag.heightOf(context);
                return const AppTag(label: '50% off');
              },
            ),
          ),
        ),
      );

      expect(tester.getSize(find.byType(AppTag)).height, predicted);
    }
  });

  testWidgets('the padding sets the height around a one-line label', (
    tester,
  ) async {
    await pumpThemed(
      tester,
      const Center(child: AppTag(label: 'New', rim: false, cornerRadius: 6)),
    );

    final shape = _shapeOf(tester) as RoundedRectangleBorder;
    expect(shape.side, BorderSide.none);
    expect(tester.getSize(find.byType(AppTag)).height, 2 * AppSpacing.s + 13);
  });

  testWidgets('a small tag is a rimmed orange pill', (tester) async {
    await pumpThemed(
      tester,
      const Center(child: AppTag.small(label: 'New shop')),
    );

    final shape = _shapeOf(tester) as StadiumBorder;
    expect(shape.side.width, AppSizes.rim);
  });

  testWidgets('a plain tag is a white pill with no rim', (tester) async {
    await pumpThemed(
      tester,
      const Center(child: AppTag.plain(label: '500 points left')),
    );

    final box = tester.widget<DecoratedBox>(
      find.descendant(
        of: find.byType(AppTag),
        matching: find.byType(DecoratedBox),
      ),
    );
    final decoration = box.decoration as ShapeDecoration;
    expect(decoration.color, Colors.white);
    expect((decoration.shape as StadiumBorder).side, BorderSide.none);
    final label = tester.getRect(find.text('500 points left'));
    final tag = tester.getRect(find.byType(AppTag));
    expect(label.top - tag.top, AppSpacing.s);
    expect(tag.bottom - label.bottom, AppSpacing.s);
  });

  testWidgets('a count tag groups the number and is at least its diameter', (
    tester,
  ) async {
    await pumpThemed(
      tester,
      Center(child: AppTag.count(count: 2, diameter: 30)),
    );

    expect(find.text('2'), findsOneWidget);
    expect(tester.getSize(find.byType(AppTag)), const Size(30, 30));

    await pumpThemed(
      tester,
      Center(child: AppTag.count(count: 1200, diameter: 18)),
    );
    expect(find.text('1,200'), findsOneWidget);
  });
}
