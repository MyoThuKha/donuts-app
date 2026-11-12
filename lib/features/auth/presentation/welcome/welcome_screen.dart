import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/stagger.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:donuts/features/auth/presentation/welcome/views/welcome_tiles_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

/// Shown once, right after registration.
class WelcomeScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) => const _WelcomePage();
}

class _WelcomePage extends StatelessWidget {
  const new();

  /// The title fades up once all four tiles have started sliding in.
  static const int _afterTiles = 5;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [colors.authBottom, colors.authTop],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.l,
              AppSpacing.l,
              0,
              AppSpacing.xxl,
            ),
            child: Column(
              children: [
                const Expanded(child: WelcomeTilesView()),
                const SizedBox(height: AppSpacing.xxl),
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.l),
                  child: Column(
                    children: [
                      StaggeredEntrance(
                        index: _afterTiles,
                        child: Text(
                          l10n.welcomeTitle,
                          style: context.text.display,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      StaggeredEntrance(
                        index: _afterTiles + 1,
                        child: AppPrimaryButton(
                          label: l10n.letsExplore,
                          onPressed: context.read<SessionCubit>().welcomeSeen,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
