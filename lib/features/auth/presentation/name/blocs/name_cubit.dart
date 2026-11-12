import 'package:donuts/features/auth/domain/validators/name_validator.dart';
import 'package:donuts/features/auth/presentation/flow/blocs/registration_draft_cubit.dart';
import 'package:donuts/features/auth/presentation/name/blocs/name_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameCubit extends Cubit<NameState> {
  new({required this._draft})
    : super(
        NameState(
          first: validateFirstName(_draft.state.firstName),
          last: validateLastName(_draft.state.lastName),
        ),
      );

  final RegistrationDraftCubit _draft;

  void firstChanged(String input) {
    emit(state.copyWith(first: validateFirstName(input)));
    _save(firstName: input);
  }

  void lastChanged(String input) {
    emit(state.copyWith(last: validateLastName(input)));
    _save(lastName: input);
  }

  void firstBlurred() => emit(state.copyWith(showFirstError: true));

  void lastBlurred() => emit(state.copyWith(showLastError: true));

  /// Keeps the raw text in the draft so going back shows it unchanged.
  void _save({String? firstName, String? lastName}) => _draft.namesEntered(
    firstName: firstName ?? _draft.state.firstName,
    lastName: lastName ?? _draft.state.lastName,
  );
}
