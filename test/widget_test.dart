import 'package:donuts/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DonutsApp shows the app name on launch', (tester) async {
    await tester.pumpWidget(const DonutsApp());

    expect(find.text("J'Donuts"), findsOneWidget);
  });
}
