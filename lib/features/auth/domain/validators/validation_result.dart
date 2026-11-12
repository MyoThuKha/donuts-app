import 'package:equatable/equatable.dart';

/// Why an input was rejected. Presentation maps each to a message.
enum ValidationError {
  empty,
  invalidPhone,
  incompleteOtp,
  tooLong,
  invalidCharacters,
  incompleteDate,
  notARealDate,
  inFuture,
  tooYoung,
}

sealed class ValidationResult<T> extends Equatable {
  const new();

  bool get isValid => this is Valid<T>;
}

final class Valid<T> extends ValidationResult<T> {
  const new(this.value);

  final T value;

  @override
  List<Object?> get props => [value];
}

final class Invalid<T> extends ValidationResult<T> {
  const new(this.error);

  final ValidationError error;

  @override
  List<Object?> get props => [error];
}
