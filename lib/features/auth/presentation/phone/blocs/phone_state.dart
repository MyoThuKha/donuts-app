import 'package:donuts/features/auth/domain/validators/validation_result.dart';
import 'package:equatable/equatable.dart';

enum PhoneStatus {
  editing,
  submitting,
  notRegistered,
  alreadyRegistered,
  failed,
}

final class PhoneState extends Equatable {
  const new({
    required this.input,
    required this.validation,
    this.showError = false,
    this.status = PhoneStatus.editing,
  });

  final String input;
  final ValidationResult<String> validation;

  /// Set once the field loses focus, so typing isn't interrupted by errors.
  final bool showError;
  final PhoneStatus status;

  String? get phone => switch (validation) {
    Valid(:final value) => value,
    Invalid() => null,
  };

  PhoneState copyWith({
    String? input,
    ValidationResult<String>? validation,
    bool? showError,
    PhoneStatus? status,
  }) => PhoneState(
    input: input ?? this.input,
    validation: validation ?? this.validation,
    showError: showError ?? this.showError,
    status: status ?? this.status,
  );

  @override
  List<Object?> get props => [input, validation, showError, status];
}
