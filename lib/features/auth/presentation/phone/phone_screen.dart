import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/core/widgets/inputs/text_field.dart';
import 'package:donuts/features/auth/domain/auth_rules.dart';
import 'package:donuts/features/auth/domain/types/auth_mode.dart';
import 'package:donuts/features/auth/presentation/flow/blocs/registration_draft_cubit.dart';
import 'package:donuts/features/auth/presentation/phone/blocs/phone_cubit.dart';
import 'package:donuts/features/auth/presentation/phone/blocs/phone_state.dart';
import 'package:donuts/features/auth/presentation/widgets/auth_step_scaffold_widget.dart';
import 'package:donuts/features/auth/presentation/widgets/validation_messages.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class PhoneScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) =>
        getIt<PhoneCubit>(param1: context.read<RegistrationDraftCubit>()),
    child: const _PhonePage(),
  );
}

class _PhonePage extends StatefulWidget {
  const new();

  @override
  State<_PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<_PhonePage> {
  late final TextEditingController _controller = TextEditingController(
    text: context.read<PhoneCubit>().state.input,
  );
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() {
      if (!_focus.hasFocus) context.read<PhoneCubit>().blurred();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final mode = context.read<RegistrationDraftCubit>().state.mode;
    final sent = await context.read<PhoneCubit>().submit();
    if (!sent || !mounted) return;
    await context.push(
      mode == AuthMode.logIn ? AppRoutes.logInOtp : AppRoutes.registerOtp,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final steps = context.read<RegistrationDraftCubit>().state.stepCount;
    return BlocBuilder<PhoneCubit, PhoneState>(
      builder: (context, state) => AuthStepScaffold(
        title: l10n.phoneTitle,
        step: 1,
        of: steps,
        busy: state.status == PhoneStatus.submitting,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _field(state),
            _AccountNotice(status: state.status),
          ],
        ),
        bottom: AppPrimaryButton(
          label: l10n.continueLabel,
          loading: state.status == PhoneStatus.submitting,
          onPressed: state.phone == null ? null : _submit,
        ),
      ),
    );
  }

  Widget _field(PhoneState state) => AppTextField(
    controller: _controller,
    focusNode: _focus,
    hint: context.l10n.phoneHint,
    prefixText: AuthRules.countryCode,
    autofocus: true,
    keyboardType: TextInputType.phone,
    autofillHints: const [AutofillHints.telephoneNumberNational],
    inputFormatters: [FilteringTextInputFormatter.allow(_phoneCharacters)],
    errorText: state.showError
        ? context.l10n.phoneError(state.validation)
        : null,
    onChanged: context.read<PhoneCubit>().changed,
    onSubmitted: (_) => _submit(),
  );
}

/// Digits plus the separators people type or paste with a number.
final RegExp _phoneCharacters = RegExp(r'[\d +-]');

/// The inline message when the number doesn't match the chosen path, with a
/// link to the other path.
class _AccountNotice extends StatelessWidget {
  const new({required this.status});

  final PhoneStatus status;

  /// The message, and the link to the other path when there is one.
  (String, String?, String?)? _notice(AppLocalizations l10n) =>
      switch (status) {
        PhoneStatus.notRegistered => (
          l10n.notRegistered,
          l10n.registerInstead,
          AppRoutes.registerPhone,
        ),
        PhoneStatus.alreadyRegistered => (
          l10n.alreadyRegistered,
          l10n.logInInstead,
          AppRoutes.logInPhone,
        ),
        PhoneStatus.failed => (l10n.genericError, null, null),
        _ => null,
      };

  @override
  Widget build(BuildContext context) {
    final notice = _notice(context.l10n);
    if (notice == null) return const SizedBox.shrink();
    final (message, action, route) = notice;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.m),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(message, style: context.text.bodySmall),
          if (action != null && route != null) _link(context, action, route),
        ],
      ),
    );
  }

  Widget _link(BuildContext context, String action, String route) => TextButton(
    onPressed: () => context.go(route),
    style: TextButton.styleFrom(
      minimumSize: const Size(AppSizes.button, AppSizes.button),
    ),
    child: Text(
      action,
      style: context.text.label.copyWith(color: context.colors.accent),
    ),
  );
}
