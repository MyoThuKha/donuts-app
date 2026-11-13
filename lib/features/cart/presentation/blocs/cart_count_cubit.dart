import 'dart:async';

import 'package:donuts/features/cart/domain/usecases/watch_cart_count_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// How many items the cart holds, for the Settings cart tag. Shows 0 until
/// it loads, and when the stream fails.
class CartCountCubit extends Cubit<int> {
  new(this._watchCount) : super(0);

  final WatchCartCountUseCase _watchCount;
  StreamSubscription<int>? _subscription;

  void start() {
    unawaited(_subscription?.cancel());
    _subscription = _watchCount().listen(
      _emitIfOpen,
      onError: (Object error, StackTrace stackTrace) {
        _emitIfOpen(0);
        if (!isClosed) addError(error, stackTrace);
      },
    );
  }

  void _emitIfOpen(int count) {
    if (!isClosed) emit(count);
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    await super.close();
  }
}
