import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/core/widgets/inputs/text_field.dart';
import 'package:donuts/features/auth/presentation/dob/blocs/dob_cubit.dart';
import 'package:donuts/features/auth/presentation/dob/blocs/dob_state.dart';
import 'package:donuts/features/auth/presentation/dob/widgets/month_field_widget.dart';
import 'package:donuts/features/auth/presentation/flow/blocs/registration_draft_cubit.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:donuts/features/auth/presentation/widgets/auth_step_scaffold_widget.dart';
import 'package:donuts/features/auth/presentation/widgets/validation_messages.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class DobScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => DobCubit(
      register: getIt(),
      draft: context.read<RegistrationDraftCubit>(),
      now: getIt(),
    ),
    child: const _DobPage(),
  );
}

class _DobPage extends StatefulWidget {
  const new();

  @override
  State<_DobPage> createState() => _DobPageState();
}

class _DobPageState extends State<_DobPage> {
  static const int _dayDigits = 2;
  static const int _yearDigits = 4;

  late final DobState _initial = context.read<DobCubit>().state;
  late final TextEditingController _day = TextEditingController(
    text: _initial.day?.toString() ?? '',
  );
  late final TextEditingController _year = TextEditingController(
    text: _initial.year?.toString() ?? '',
  );

  @override
  void dispose() {
    _day.dispose();
    _year.dispose();
    super.dispose();
  }

  void _changed({int? month}) {
    final cubit = context.read<DobCubit>();
    cubit.changed(
      day: int.tryParse(_day.text),
      month: month ?? cubit.state.month,
      year: int.tryParse(_year.text),
    );
  }

  Future<void> _submit() async {
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
        body: Column(
          children: [
            MonthFieldWidget(
              month: state.month,
              hint: l10n.monthHint,
              onChanged: (month) => _changed(month: month),
            ),
            const SizedBox(height: AppSpacing.m),
            _numberField(_day, l10n.dayHint, _dayDigits),
            const SizedBox(height: AppSpacing.m),
            _numberField(
              _year,
              l10n.yearHint,
              _yearDigits,
              error: l10n.dateOfBirthError(state.validation),
            ),
            if (state.status == DobStatus.failed)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.s),
                child: Text(
                  l10n.genericError,
                  style: context.text.caption.copyWith(
                    color: context.colors.danger,
                  ),
                ),
              ),
          ],
        ),
        bottom: AppPrimaryButton(
          label: l10n.continueLabel,
          loading: state.status == DobStatus.submitting,
          onPressed: state.validation.isValid ? _submit : null,
        ),
      ),
    );
  }

  Widget _numberField(
    TextEditingController controller,
    String hint,
    int digits, {
    String? error,
  }) => AppTextField(
    controller: controller,
    hint: hint,
    errorText: error,
    keyboardType: TextInputType.number,
    textInputAction: TextInputAction.next,
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(digits),
    ],
    onChanged: (_) => _changed(),
  );
}
