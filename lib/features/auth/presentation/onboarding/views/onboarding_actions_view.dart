import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/core/widgets/sheets/placeholder_sheet.dart';
import 'package:donuts/features/auth/presentation/widgets/social_sign_in_row_widget.dart';
import 'package:donuts/features/auth/presentation/widgets/terms_notice_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

/// Title, Let's get started, the Log In row, social sign-in and terms.
class OnboardingActionsView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.onboardingTitle,
          style: context.text.display,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xxl),
        AppPrimaryButton(
          label: l10n.getStarted,
          onPressed: () => showPlaceholderSheet(
            context,
            message: l10n.registrationComingSoon,
          ),
        ),
        const SizedBox(height: AppSpacing.l),
        const _LogInRow(),
        const SizedBox(height: AppSpacing.m),
        const SocialSignInRowWidget(),
        const SizedBox(height: AppSpacing.l),
        const TermsNoticeWidget(),
      ],
    );
  }
}

class _LogInRow extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(l10n.alreadyHaveAccount, style: context.text.bodySmall),
        TextButton(
          onPressed: () => context.push(AppRoutes.logInPhone),
          style: TextButton.styleFrom(
            minimumSize: const Size(AppSizes.button, AppSizes.button),
          ),
          child: Text(
            l10n.logIn,
            style: context.text.label.copyWith(color: context.colors.accent),
          ),
        ),
      ],
    );
  }
}
