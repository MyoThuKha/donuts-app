import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/core/widgets/inputs/text_field.dart';
import 'package:donuts/features/auth/presentation/flow/blocs/registration_draft_cubit.dart';
import 'package:donuts/features/auth/presentation/name/blocs/name_cubit.dart';
import 'package:donuts/features/auth/presentation/name/blocs/name_state.dart';
import 'package:donuts/features/auth/presentation/widgets/auth_step_scaffold_widget.dart';
import 'package:donuts/features/auth/presentation/widgets/validation_messages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class NameScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) =>
        NameCubit(draft: context.read<RegistrationDraftCubit>()),
    child: const _NamePage(),
  );
}

class _NamePage extends StatefulWidget {
  const new();

  @override
  State<_NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<_NamePage> {
  late final RegistrationDraftCubit _draft = context
      .read<RegistrationDraftCubit>();
  late final TextEditingController _first = TextEditingController(
    text: _draft.state.firstName,
  );
  late final TextEditingController _last = TextEditingController(
    text: _draft.state.lastName,
  );
  final FocusNode _firstFocus = FocusNode();
  final FocusNode _lastFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<NameCubit>();
    _firstFocus.addListener(() {
      if (!_firstFocus.hasFocus) cubit.firstBlurred();
    });
    _lastFocus.addListener(() {
      if (!_lastFocus.hasFocus) cubit.lastBlurred();
    });
  }

  @override
  void dispose() {
    _first.dispose();
    _last.dispose();
    _firstFocus.dispose();
    _lastFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<NameCubit>();
    return BlocBuilder<NameCubit, NameState>(
      builder: (context, state) => AuthStepScaffold(
        title: l10n.nameTitle,
        step: 3,
        of: _draft.state.stepCount,
        body: Column(
          children: [
            AppTextField(
              controller: _first,
              focusNode: _firstFocus,
              hint: l10n.firstNameHint,
              autofocus: true,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.givenName],
              errorText: state.showFirstError
                  ? l10n.nameError(state.first)
                  : null,
              onChanged: cubit.firstChanged,
            ),
            const SizedBox(height: AppSpacing.m),
            AppTextField(
              controller: _last,
              focusNode: _lastFocus,
              hint: l10n.lastNameHint,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.familyName],
              errorText: state.showLastError
                  ? l10n.nameError(state.last)
                  : null,
              onChanged: cubit.lastChanged,
            ),
          ],
        ),
        bottom: AppPrimaryButton(
          label: l10n.continueLabel,
          onPressed: state.canContinue
              ? () => context.push(AppRoutes.registerDob)
              : null,
        ),
      ),
    );
  }
}
