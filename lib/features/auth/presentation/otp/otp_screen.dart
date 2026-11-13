import 'dart:async';

import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/auth/domain/types/auth_mode.dart';
import 'package:donuts/features/auth/presentation/flow/blocs/registration_draft_cubit.dart';
import 'package:donuts/features/auth/presentation/otp/blocs/otp_cubit.dart';
import 'package:donuts/features/auth/presentation/otp/blocs/otp_state.dart';
import 'package:donuts/features/auth/presentation/otp/widgets/otp_input_widget.dart';
import 'package:donuts/features/auth/presentation/otp/widgets/resend_countdown_widget.dart';
import 'package:donuts/features/auth/presentation/otp/widgets/shake_widget.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:donuts/features/auth/presentation/widgets/auth_step_scaffold_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class OtpScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final draft = context.read<RegistrationDraftCubit>().state;
    return BlocProvider(
      create: (_) => getIt<OtpCubit>(param1: draft)..startCountdown(),
      child: const _OtpPage(),
    );
  }
}

class _OtpPage extends StatelessWidget {
  const new();

  void _onVerified(BuildContext context, OtpState state) {
    final cubit = context.read<OtpCubit>();
    if (cubit.mode == AuthMode.register) {
      unawaited(context.push(AppRoutes.registerName));
    } else if (state.user case final user?) {
      context.read<SessionCubit>().signedIn(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<OtpCubit>();
    final steps = context.read<RegistrationDraftCubit>().state.stepCount;
    return BlocConsumer<OtpCubit, OtpState>(
      listenWhen: (a, b) =>
          b.status == OtpStatus.verified && a.status != b.status,
      listener: _onVerified,
      builder: (context, state) => AuthStepScaffold(
        title: l10n.otpTitle,
        subtitle: l10n.otpSent(cubit.phone),
        step: 2,
        of: steps,
        busy: state.status == OtpStatus.verifying,
        body: _OtpBody(state: state),
        bottom: const SizedBox.shrink(),
      ),
    );
  }
}

/// The boxes, the message under them and the resend countdown.
class _OtpBody extends StatelessWidget {
  const new({required this.state});

  final OtpState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OtpCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShakeWidget(
          trigger: state.shakeCount,
          child: OtpInputWidget(
            code: state.code,
            enabled: !state.locked,
            busy: state.status == OtpStatus.verifying,
            onChanged: cubit.changed,
          ),
        ),
        _OtpMessage(state: state),
        const SizedBox(height: AppSpacing.xxl),
        ResendCountdownWidget(
          remaining: state.remaining,
          canResend: state.canResend,
          onResend: cubit.resend,
        ),
      ],
    );
  }
}

class _OtpMessage extends StatelessWidget {
  const new({required this.state});

  static const double _spinnerSize = 20;
  static const double _spinnerStroke = 2.5;

  final OtpState state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final message = state.locked
        ? l10n.otpLocked
        : switch (state.status) {
            OtpStatus.wrong => l10n.otpWrong,
            OtpStatus.failed => l10n.genericError,
            _ => null,
          };
    if (state.status == OtpStatus.verifying) {
      return const Padding(
        padding: EdgeInsets.only(top: AppSpacing.m),
        child: SizedBox.square(
          dimension: _spinnerSize,
          child: CircularProgressIndicator(strokeWidth: _spinnerStroke),
        ),
      );
    }
    if (message == null) return const SizedBox(height: AppSpacing.l);
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.s),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(message, style: context.text.error),
          // A check that failed for another reason than a wrong code can
          // run again on the same six digits.
          if (state.status == OtpStatus.failed && !state.locked)
            TextButton(
              onPressed: context.read<OtpCubit>().verify,
              style: TextButton.styleFrom(
                minimumSize: const Size(AppSizes.button, AppSizes.button),
              ),
              child: Text(l10n.otpRetry, style: context.text.link),
            ),
        ],
      ),
    );
  }
}
