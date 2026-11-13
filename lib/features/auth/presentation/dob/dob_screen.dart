import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/core/widgets/inputs/date_wheel_sheet.dart';
import 'package:donuts/core/widgets/inputs/picker_field.dart';
import 'package:donuts/features/auth/domain/validators/validation_result.dart';
import 'package:donuts/features/auth/presentation/dob/blocs/dob_cubit.dart';
import 'package:donuts/features/auth/presentation/dob/blocs/dob_state.dart';
import 'package:donuts/features/auth/presentation/flow/blocs/registration_draft_cubit.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:donuts/features/auth/presentation/widgets/auth_step_scaffold_widget.dart';
import 'package:donuts/features/auth/presentation/widgets/validation_messages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

class DobScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) =>
        getIt<DobCubit>(param1: context.read<RegistrationDraftCubit>()),
    child: const _DobPage(),
  );
}

class _DobPage extends StatelessWidget {
  const new();

  /// Each field opens the same wheel, which sets all three parts at once.
  Future<void> _pick(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final cubit = context.read<DobCubit>();
    final range = cubit.range;
    final picked = await showDateWheelSheet(
      context,
      title: context.l10n.dobPickerTitle,
      initial: switch (cubit.state.validation) {
        Valid(:final value) => value,
        Invalid() => range.latest,
      },
      earliest: range.earliest,
      latest: range.latest,
    );
    if (picked == null || cubit.isClosed) return;
    cubit.changed(day: picked.day, month: picked.month, year: picked.year);
  }

  Future<void> _submit(BuildContext context) async {
    final session = context.read<SessionCubit>();
    final user = await context.read<DobCubit>().submit();
    if (user != null) session.signedIn(user, justRegistered: true);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final steps = context.read<RegistrationDraftCubit>().state.stepCount;
    return BlocBuilder<DobCubit, DobState>(
      builder: (context, state) => AuthStepScaffold(
        title: l10n.dobTitle,
        step: steps,
        of: steps,
        busy: state.status == DobStatus.submitting,
        body: _fields(context, state),
        bottom: AppPrimaryButton(
          label: l10n.continueLabel,
          loading: state.status == DobStatus.submitting,
          onPressed: state.validation.isValid ? () => _submit(context) : null,
        ),
      ),
    );
  }

  Widget _fields(BuildContext context, DobState state) {
    final l10n = context.l10n;
    final month = state.month;
    void pick() => _pick(context);
    return Column(
      spacing: AppSpacing.m,
      children: [
        AppPickerField(
          hint: l10n.monthHint,
          value: month == null ? null : _monthName(context, month),
          onTap: pick,
        ),
        AppPickerField(
          hint: l10n.dayHint,
          value: state.day?.toString(),
          onTap: pick,
        ),
        AppPickerField(
          hint: l10n.yearHint,
          value: state.year?.toString(),
          errorText: l10n.dateOfBirthError(state.validation),
          onTap: pick,
        ),
        if (state.status == DobStatus.failed)
          Text(
            l10n.genericError,
            style: context.text.caption.copyWith(color: context.colors.danger),
          ),
      ],
    );
  }

  static String _monthName(BuildContext context, int month) =>
      DateFormat.MMMM(Localizations.localeOf(context).toLanguageTag())
          .format(DateTime(2000, month));
}
