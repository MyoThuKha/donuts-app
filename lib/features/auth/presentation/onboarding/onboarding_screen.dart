import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/auth/presentation/onboarding/views/onboarding_actions_view.dart';
import 'package:donuts/features/auth/presentation/onboarding/views/onboarding_hero_view.dart';
import 'package:material_ui/material_ui.dart';

class OnboardingScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) => const _OnboardingPage();
}

class _OnboardingPage extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [colors.authTop, colors.authBottom],
          ),
        ),
        child: const SafeArea(
          top: false,
          child: Column(
            children: [
              Expanded(child: OnboardingHeroView()),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.authGutter,
                  AppSpacing.xxl,
                  AppSpacing.authGutter,
                  AppSpacing.l,
                ),
                child: OnboardingActionsView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
