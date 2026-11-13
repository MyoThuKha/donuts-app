import 'dart:async';

import 'package:donuts/core/state/section_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Follows streams into parts of a cubit's state, one subscription per
/// [K]. Each part shows loading on (re)subscribe, and an error fails only
/// that part.
mixin SectionWatcher<K, S> on BlocBase<S> {
  final Map<K, StreamSubscription<Object?>> _sections = {};

  /// Sets part [key] to loading, then follows [source] into it through
  /// [put]. Replaces any earlier subscription for [key].
  void watchSection<T>(
    K key,
    Stream<SectionState<T>> source,
    S Function(SectionState<T> section) put,
  ) {
    unawaited(_sections.remove(key)?.cancel());
    _emitIfOpen(put(SectionLoading<T>()));
    _sections[key] = source.listen(
      (section) => _emitIfOpen(put(section)),
      onError: (Object error, StackTrace stackTrace) {
        addError(error, stackTrace);
        _emitIfOpen(put(SectionFailed<T>()));
      },
    );
  }

  /// Stops following part [key].
  void unwatchSection(K key) => unawaited(_sections.remove(key)?.cancel());

  /// Bloc always emits its first state, even one equal to the initial
  /// state, so an unchanged state is skipped here.
  void _emitIfOpen(S next) {
    if (!isClosed && next != state) emit(next);
  }

  @override
  Future<void> close() async {
    final current = [..._sections.values];
    _sections.clear();
    await Future.wait([for (final s in current) s.cancel()]);
    await super.close();
  }
}
