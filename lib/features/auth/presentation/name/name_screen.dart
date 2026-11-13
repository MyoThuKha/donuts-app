import 'package:donuts/core/di/locator.dart';
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
        getIt<NameCubit>(param1: context.read<RegistrationDraftCubit>()),
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

  /// True from a Continue tap until the user comes back from the date
  /// step, so a second quick tap doesn't push that step twice.
  bool _leaving = false;

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
    return BlocBuilder<NameCubit, NameState>(
      builder: (context, state) => AuthStepScaffold(
        title: l10n.nameTitle,
        step: 3,
        of: _draft.state.stepCount,
        body: Column(
          spacing: AppSpacing.m,
          children: [_firstField(state), _lastField(state)],
        ),
        bottom: AppPrimaryButton(
          label: l10n.continueLabel,
          onPressed: state.canContinue ? _continue : null,
        ),
      ),
    );
  }

  Future<void> _continue() async {
    if (_leaving) return;
    _leaving = true;
    await context.push(AppRoutes.registerDob);
    _leaving = false;
  }

  Widget _firstField(NameState state) => AppTextField(
    controller: _first,
    focusNode: _firstFocus,
    hint: context.l10n.firstNameHint,
    autofocus: true,
    textInputAction: TextInputAction.next,
    autofillHints: const [AutofillHints.givenName],
    errorText: state.showFirstError
        ? context.l10n.nameError(state.first)
        : null,
    onChanged: context.read<NameCubit>().firstChanged,
  );

  Widget _lastField(NameState state) => AppTextField(
    controller: _last,
    focusNode: _lastFocus,
    hint: context.l10n.lastNameHint,
    textInputAction: TextInputAction.done,
    autofillHints: const [AutofillHints.familyName],
    errorText: state.showLastError ? context.l10n.nameError(state.last) : null,
    onChanged: context.read<NameCubit>().lastChanged,
  );
}
