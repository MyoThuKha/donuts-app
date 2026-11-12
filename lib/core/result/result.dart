import 'package:donuts/core/result/app_failure.dart';

/// The outcome of a repository or use case call. Failures travel as values,
/// so a `switch` that forgets the failure case doesn't compile.
sealed class Result<T> {
  const new();

  Result<R> map<R>(R Function(T data) transform) => switch (this) {
    Success(:final data) => Success(transform(data)),
    Failure(:final failure) => Failure(failure),
  };
}

final class Success<T> extends Result<T> {
  const new(this.data);

  final T data;
}

final class Failure<T> extends Result<T> {
  const new(this.failure);

  final AppFailure failure;
}
