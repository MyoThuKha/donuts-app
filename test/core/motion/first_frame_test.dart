import 'package:donuts/core/motion/first_frame.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  tearDown(FirstFrame.debugReset);

  test('without a hold the first frame counts as shown', () async {
    expect(FirstFrame.isShown, isTrue);
    await expectLater(FirstFrame.shown, completes);
  });

  test('a held frame is shown once the hold ends', () async {
    final hold = FirstFrame.debugHold();
    expect(FirstFrame.isShown, isFalse);

    hold.complete();
    await FirstFrame.shown;
    expect(FirstFrame.isShown, isTrue);
  });
}
