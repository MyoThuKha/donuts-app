import 'package:donuts/features/rewards/domain/tier_progress.dart';
import 'package:donuts/features/rewards/domain/vo/tier_vo.dart';
import 'package:flutter_test/flutter_test.dart';

const _silver = TierVO(id: 'silver', name: 'Silver', minPoints: 678500);
const _gold = TierVO(id: 'gold', name: 'Gold', minPoints: 680500);
const _platinum = TierVO(id: 'platinum', name: 'Platinum', minPoints: 1000000);
const List<TierVO> _tiers = [_silver, _gold, _platinum];

void main() {
  test(
    '680,000 points are Silver with Gold next, 500 to go and 75% progress',
    () {
      final progress = resolveTierProgress(680000, _tiers);

      expect(progress.current, _silver);
      expect(progress.next, _gold);
      expect(progress.pointsToNext, 500);
      expect(progress.progress, 0.75);
    },
  );

  test('points below the lowest tier have no current tier and Silver next', () {
    final progress = resolveTierProgress(339250, _tiers);

    expect(progress.current, isNull);
    expect(progress.next, _silver);
    expect(progress.pointsToNext, 339250);
    expect(progress.progress, 0.5);
  });

  test('points at or above Platinum have no next tier and full progress', () {
    for (final points in [1000000, 1200000]) {
      final progress = resolveTierProgress(points, _tiers);

      expect(progress.current, _platinum);
      expect(progress.next, isNull);
      expect(progress.pointsToNext, isNull);
      expect(progress.progress, 1);
    }
  });

  test('points exactly at Gold make Gold current and Platinum next with zero '
      'progress', () {
    final progress = resolveTierProgress(680500, _tiers);

    expect(progress.current, _gold);
    expect(progress.next, _platinum);
    expect(progress.progress, 0);
  });

  test('tiers given out of order are sorted by points', () {
    final progress = resolveTierProgress(680000, [_platinum, _gold, _silver]);

    expect(progress.current, _silver);
    expect(progress.next, _gold);
  });

  test('no tiers at all gives no current or next tier', () {
    final progress = resolveTierProgress(680000, const []);

    expect(progress.current, isNull);
    expect(progress.next, isNull);
    expect(progress.progress, 1);
  });
}
