import 'package:donuts/features/auth/domain/types/auth_mode.dart';
import 'package:donuts/features/auth/presentation/flow/blocs/registration_draft_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Holds a sign-up or log-in attempt's input for the whole flow, so the back
/// arrow returns to a step with what was typed still there.
class RegistrationDraftCubit extends Cubit<RegistrationDraftState> {
  new(AuthMode mode) : super(RegistrationDraftState(mode: mode));

  void phoneEntered(String input, String? normalized) =>
      emit(state.copyWith(phoneInput: input, phone: () => normalized));

  void namesEntered({required String firstName, required String lastName}) =>
      emit(state.copyWith(firstName: firstName, lastName: lastName));

  void dobEntered({int? day, int? month, int? year}) => emit(
    state.copyWith(day: () => day, month: () => month, year: () => year),
  );
}
