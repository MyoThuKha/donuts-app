import 'package:donuts/core/widgets/buttons/back_button.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/pump_app.dart';

void main() {
  testWidgets('screen readers can press Back', (tester) async {
    final handle = tester.ensureSemantics();
    var presses = 0;
    await pumpThemed(tester, AppBackButton(onPressed: () => presses++));

    tester.semantics.tap(find.semantics.byLabel('Back'));

    expect(presses, 1);
    handle.dispose();
  });

  testWidgets('a disabled Back offers screen readers no tap', (tester) async {
    final handle = tester.ensureSemantics();
    await pumpThemed(tester, AppBackButton(onPressed: () {}, enabled: false));

    expect(
      () => tester.semantics.tap(find.semantics.byLabel('Back')),
      throwsStateError,
    );
    handle.dispose();
  });
}
