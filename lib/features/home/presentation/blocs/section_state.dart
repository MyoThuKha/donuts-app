import 'package:equatable/equatable.dart';

/// Where one Home section stands. Each section loads, fails and empties
/// on its own, so one bad stream never blanks the others.
sealed class SectionState<T> extends Equatable {
  const new();

  @override
  List<Object?> get props => [];
}

/// Waiting for the section's first emission. The section shows a skeleton.
final class SectionLoading<T> extends SectionState<T> {
  const new();
}

/// The section has something to show. Never holds an empty list.
final class SectionReady<T> extends SectionState<T> {
  const new(this.data);

  final T data;

  @override
  List<Object?> get props => [data];
}

/// The source emitted nothing to show.
final class SectionEmpty<T> extends SectionState<T> {
  const new();
}

/// The source failed. The section offers a retry.
final class SectionFailed<T> extends SectionState<T> {
  const new();
}
