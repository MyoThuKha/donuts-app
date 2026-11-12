import 'package:donuts/app/router/session_listenable.dart';
import 'package:donuts/app/shell/app_shell.dart';
import 'package:donuts/app/shell/placeholder_tab_screen.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/features/auth/presentation/onboarding/onboarding_screen.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_state.dart';
import 'package:donuts/features/settings/presentation/settings_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

GoRouter buildAppRouter({
  required SessionCubit session,
  String initialLocation = AppRoutes.home,
}) {
  final refresh = SessionListenable(session);
  return GoRouter(
    initialLocation: initialLocation,
    refreshListenable: refresh,
    redirect: (context, state) =>
        authRedirect(session.state, state.matchedLocation),
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => PlaceholderTabScreen(
          key: const ValueKey(AppRoutes.welcome),
          title: context.l10n.welcomeTitle,
        ),
      ),
      GoRoute(
        path: AppRoutes.logInPhone,
        builder: (context, state) =>
            PlaceholderTabScreen(title: context.l10n.logIn),
      ),
      _shell(),
    ],
  );
}

/// Where the guard sends a user, or `null` to let them through.
String? authRedirect(SessionState session, String location) {
  final public = AppRoutes.isPublic(location);
  return switch (session) {
    SessionSignedOut() => public ? null : AppRoutes.onboarding,
    SessionSignedIn(justRegistered: true) =>
      location == AppRoutes.welcome ? null : AppRoutes.welcome,
    SessionSignedIn() =>
      public || location == AppRoutes.welcome ? AppRoutes.home : null,
  };
}

StatefulShellRoute _shell() => StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) =>
      AppShell(navigationShell: navigationShell),
  branches: [
    _placeholderBranch(AppRoutes.home, (l10n) => l10n.tabHome),
    _placeholderBranch(AppRoutes.rewards, (l10n) => l10n.tabReward),
    _placeholderBranch(AppRoutes.explore, (l10n) => l10n.tabExplore),
    _placeholderBranch(AppRoutes.wallet, (l10n) => l10n.tabWallet),
    StatefulShellBranch(
      routes: [
        GoRoute(
          path: AppRoutes.settings,
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);

StatefulShellBranch _placeholderBranch(
  String path,
  String Function(AppLocalizations l10n) title,
) {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        path: path,
        builder: (context, state) =>
            PlaceholderTabScreen(title: title(context.l10n)),
      ),
    ],
  );
}
