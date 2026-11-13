import 'dart:async';

import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/features/cart/presentation/blocs/cart_count_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/cart_fakes.dart';

void main() {
  late MockWatchCartCountUseCase watchCount;
  late StreamController<int> counts;

  setUp(() {
    watchCount = MockWatchCartCountUseCase();
    counts = StreamController<int>();
    when(watchCount.call).thenAnswer((_) => counts.stream);
  });
  tearDown(() => counts.close());

  test('follows the count, starting at 0', () async {
    final cubit = CartCountCubit(watchCount)..start();
    addTearDown(cubit.close);
    expect(cubit.state, 0);

    counts.add(3);
    await pumpEventQueue();

    expect(cubit.state, 3);
  });

  test('an error shows 0 and is reported', () async {
    final cubit = _RecordingCartCountCubit(watchCount)..start();
    addTearDown(cubit.close);
    counts.add(2);
    await pumpEventQueue();

    counts.addError(const DatabaseFailure());
    await pumpEventQueue();

    expect(cubit.state, 0);
    expect(cubit.errors.single, isA<DatabaseFailure>());
  });
}

class _RecordingCartCountCubit extends CartCountCubit {
  new(super._watchCount);

  final errors = <Object>[];

  @override
  void onError(Object error, StackTrace stackTrace) {
    errors.add(error);
    super.onError(error, stackTrace);
  }
}
