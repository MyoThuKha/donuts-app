import 'package:donuts/features/auth/domain/validators/validation_result.dart';
import 'package:equatable/equatable.dart';

enum DobStatus { editing, submitting, failed }

final class DobState extends Equatable {
  const new({
    required this.validation,
    this.day,
    this.month,
    this.year,
    this.status = DobStatus.editing,
  });

  final int? day;
  final int? month;
  final int? year;
  final ValidationResult<DateTime> validation;
  final DobStatus status;

  @override
  List<Object?> get props => [day, month, year, validation, status];
}
