import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/motion/stagger.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/core/widgets/buttons/primary_button.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:donuts/features/auth/presentation/welcome/views/welcome_tiles_view.dart';
import 'package:donuts/features/auth/presentation/widgets/auth_background_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthBackgroundWidget(
        backdrop: AuthBackdrop.wash,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.l,
              AppSpacing.l,
              0,
              AppSpacing.xxl,
            ),
            child: Column(
              children: [
                Expanded(child: WelcomeTilesView()),
                SizedBox(height: AppSpacing.xxl),
                _WelcomeActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WelcomeActions extends StatelessWidget {
  const new();

  /// The title fades up once all four tiles have started sliding in.
  static const int _afterTiles = 5;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      // The page pads the left by AppSpacing.l for the tiles; the actions
      // sit inside the auth gutter on both sides.
      padding: const EdgeInsets.only(
        left: AppSpacing.authGutter - AppSpacing.l,
        right: AppSpacing.authGutter,
      ),
      child: Column(
        spacing: AppSpacing.xxl,
        children: [
          StaggeredEntrance(
            index: _afterTiles,
            child: Text(
              l10n.welcomeTitle,
              style: context.text.display,
              textAlign: TextAlign.center,
            ),
          ),
          StaggeredEntrance(
            index: _afterTiles + 1,
            child: AppPrimaryButton(
              label: l10n.letsExplore,
              onPressed: context.read<SessionCubit>().welcomeSeen,
            ),
          ),
        ],
      ),
    );
  }
}
