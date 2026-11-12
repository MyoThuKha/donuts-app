import 'package:donuts/features/rewards/domain/types/challenge_kind.dart';
import 'package:donuts/features/rewards/domain/vo/challenge_vo.dart';
import 'package:flutter_test/flutter_test.dart';

ChallengeVO _challenge({required int progress, required int target}) =>
    ChallengeVO(
      id: 'c',
      title: 'Eat donuts',
      kind: ChallengeKind.donutQuarters,
      progress: progress,
      target: target,
      rewardPoints: 100,
    );

void main() {
  test('4 of 4 is complete and 9 of 12 is not', () {
    final done = _challenge(progress: 4, target: 4);
    final partway = _challenge(progress: 9, target: 12);

    expect(done.isComplete, isTrue);
    expect(done.fraction, 1);
    expect(partway.isComplete, isFalse);
    expect(partway.fraction, 0.75);
  });

  test('progress is clamped and a zero target counts as complete', () {
    expect(_challenge(progress: 7, target: 4).fraction, 1);
    expect(_challenge(progress: -2, target: 4).fraction, 0);
    expect(_challenge(progress: 0, target: 0).fraction, 1);
    expect(_challenge(progress: 0, target: 0).isComplete, isTrue);
    expect(_challenge(progress: 0, target: -1).fraction, 1);
  });
}
