import 'package:donuts/core/result/result.dart';
import 'package:donuts/features/auth/domain/params/registration_params.dart';
import 'package:donuts/features/auth/domain/usecases/register_use_case.dart';
import 'package:donuts/features/auth/domain/validators/date_of_birth_validator.dart';
import 'package:donuts/features/auth/domain/validators/name_validator.dart';
import 'package:donuts/features/auth/domain/validators/validation_result.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:donuts/features/auth/presentation/dob/blocs/dob_state.dart';
import 'package:donuts/features/auth/presentation/flow/blocs/registration_draft_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DobCubit extends Cubit<DobState> {
  new({required this._register, required this._draft, required this._now})
    : super(
        DobState(
          day: _draft.state.day,
          month: _draft.state.month,
          year: _draft.state.year,
          validation: validateDateOfBirth(
            year: _draft.state.year,
            month: _draft.state.month,
            day: _draft.state.day,
            today: _now(),
          ),
        ),
      );

  final RegisterUseCase _register;
  final RegistrationDraftCubit _draft;
  final DateTime Function() _now;

  /// The dates of birth the rules accept today, for the picker's limits.
  ({DateTime earliest, DateTime latest}) get range => dateOfBirthRange(_now());

  void changed({int? day, int? month, int? year}) {
    _draft.dobEntered(day: day, month: month, year: year);
    emit(
      DobState(
        day: day,
        month: month,
        year: year,
        validation: validateDateOfBirth(
          year: year,
          month: month,
          day: day,
          today: _now(),
        ),
        status: state.status == DobStatus.submitting
            ? DobStatus.submitting
            : DobStatus.editing,
      ),
    );
  }

  /// Creates the account from the whole draft. Returns the new user, or
  /// `null` on failure or while a request is already running.
  Future<UserVO?> submit() async {
    final params = _params();
    if (params == null || state.status == DobStatus.submitting) return null;
    emit(_withStatus(DobStatus.submitting));
    final result = await _register(params);
    if (isClosed) return null;
    return switch (result) {
      Success(:final data) => data,
      Failure() => () {
        emit(_withStatus(DobStatus.failed));
        return null;
      }(),
    };
  }

  RegistrationParams? _params() {
    final draft = _draft.state;
    final phone = draft.phone;
    return switch ((
      state.validation,
      validateFirstName(draft.firstName),
      validateLastName(draft.lastName),
    )) {
      (
        Valid(value: final dob),
        Valid(value: final first),
        Valid(value: final last),
      )
          when phone != null =>
        RegistrationParams(
          phone: phone,
          firstName: first,
          lastName: last,
          dateOfBirth: dob,
        ),
      _ => null,
    };
  }

  DobState _withStatus(DobStatus status) => DobState(
    day: state.day,
    month: state.month,
    year: state.year,
    validation: state.validation,
    status: status,
  );
}
