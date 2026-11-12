import 'package:donuts/core/theme/donuts_colors.dart';
import 'package:donuts/core/widgets/inputs/text_field.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

Color? _borderColour(WidgetTester tester) {
  final box = tester.widget<DecoratedBox>(
    find
        .descendant(
          of: find.byType(AppTextField),
          matching: find.byType(DecoratedBox),
        )
        .first,
  );
  return ((box.decoration as BoxDecoration).border! as Border).top.color;
}

void main() {
  testWidgets('shows no error text until one is given', (tester) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);
    await pumpThemed(
      tester,
      AppTextField(controller: controller, hint: 'First Name'),
    );

    expect(find.text('Enter your first name'), findsNothing);

    await pumpThemed(
      tester,
      AppTextField(
        controller: controller,
        hint: 'First Name',
        errorText: 'Enter your first name',
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Enter your first name'), findsOneWidget);
  });

  testWidgets('the border animates towards primary on focus', (tester) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);
    await pumpThemed(
      tester,
      AppTextField(controller: controller, hint: 'First Name'),
    );
    final resting = _borderColour(tester);

    await tester.tap(find.byType(TextField));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    final midway = _borderColour(tester);
    await tester.pumpAndSettle();

    expect(midway, isNot(resting));
    expect(midway, isNot(DonutsColors.light.primary));
    expect(_borderColour(tester), DonutsColors.light.primary);
  });
}
