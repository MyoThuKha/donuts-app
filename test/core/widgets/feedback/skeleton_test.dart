import 'package:donuts/core/widgets/feedback/skeleton.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../helpers/pump_app.dart';

Future<void> _pumpSkeleton(WidgetTester tester, {required bool reduce}) =>
    pumpThemed(
      tester,
      Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(context).copyWith(disableAnimations: reduce),
          child: const SkeletonGroup(child: Skeleton(width: 120, height: 16)),
        ),
      ),
    );

void main() {
  testWidgets('the skeleton draws a static box with reduce motion', (
    tester,
  ) async {
    await _pumpSkeleton(tester, reduce: true);
    await tester.pump();

    expect(find.byType(ShaderMask), findsNothing);
    expect(tester.getSize(find.byType(Skeleton)), const Size(120, 16));
    expect(tester.binding.hasScheduledFrame, isFalse);
  });

  testWidgets('the skeleton shimmers while motion is allowed', (tester) async {
    await _pumpSkeleton(tester, reduce: false);
    await tester.pump();

    expect(find.byType(ShaderMask), findsOneWidget);
    expect(tester.binding.hasScheduledFrame, isTrue);
  });
}
