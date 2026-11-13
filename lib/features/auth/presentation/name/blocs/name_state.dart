import 'package:donuts/features/auth/domain/validators/validation_result.dart';
import 'package:equatable/equatable.dart';

final class NameState extends Equatable {
  const new({
    required this.first,
    required this.last,
    this.showFirstError = false,
    this.showLastError = false,
  });

  final ValidationResult<String> first;
  final ValidationResult<String?> last;
  final bool showFirstError;
  final bool showLastError;

  bool get canContinue => first.isValid && last.isValid;

  NameState copyWith({
    ValidationResult<String>? first,
    ValidationResult<String?>? last,
    bool? showFirstError,
    bool? showLastError,
  }) => NameState(
    first: first ?? this.first,
    last: last ?? this.last,
    showFirstError: showFirstError ?? this.showFirstError,
    showLastError: showLastError ?? this.showLastError,
  );

  @override
  List<Object?> get props => [first, last, showFirstError, showLastError];
}
