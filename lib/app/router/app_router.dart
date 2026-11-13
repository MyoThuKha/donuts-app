import 'package:donuts/app/router/session_listenable.dart';
import 'package:donuts/app/router/step_transition_page.dart';
import 'package:donuts/app/shell/app_shell.dart';
import 'package:donuts/app/shell/placeholder_tab_screen.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:donuts/core/widgets/images/product_hero_tag.dart';
import 'package:donuts/features/auth/domain/types/auth_mode.dart';
import 'package:donuts/features/auth/presentation/dob/dob_screen.dart';
import 'package:donuts/features/auth/presentation/flow/blocs/registration_draft_cubit.dart';
import 'package:donuts/features/auth/presentation/name/name_screen.dart';
import 'package:donuts/features/auth/presentation/onboarding/onboarding_screen.dart';
import 'package:donuts/features/auth/presentation/otp/otp_screen.dart';
import 'package:donuts/features/auth/presentation/phone/phone_screen.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_state.dart';
import 'package:donuts/features/auth/presentation/welcome/welcome_screen.dart';
import 'package:donuts/features/home/presentation/home_screen.dart';
import 'package:donuts/features/product/presentation/product_detail_screen.dart';
import 'package:donuts/features/rewards/presentation/rewards_screen.dart';
import 'package:donuts/features/settings/presentation/settings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        builder: (context, state) =>
            const WelcomeScreen(key: ValueKey(AppRoutes.welcome)),
      ),
      _authFlow(AuthMode.logIn, [
        _step(AppRoutes.logInPhone, const PhoneScreen()),
        _step(AppRoutes.logInOtp, const OtpScreen()),
      ]),
      _authFlow(AuthMode.register, [
        _step(AppRoutes.registerPhone, const PhoneScreen()),
        _step(AppRoutes.registerOtp, const OtpScreen()),
        _step(AppRoutes.registerName, const NameScreen()),
        _step(AppRoutes.registerDob, const DobScreen()),
      ]),
      _shell(),
      GoRoute(path: AppRoutes.product, builder: _productDetail),
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

/// One sign-up or log-in attempt. Its steps share a draft, so going back
/// keeps what was typed.
ShellRoute _authFlow(AuthMode mode, List<RouteBase> steps) => ShellRoute(
  builder: (context, state, child) =>
      BlocProvider(create: (_) => RegistrationDraftCubit(mode), child: child),
  routes: steps,
);

GoRoute _step(String path, Widget screen) => GoRoute(
  path: path,
  pageBuilder: (context, state) =>
      stepTransitionPage(key: state.pageKey, child: screen),
);

StatefulShellRoute _shell() => StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) =>
      AppShell(navigationShell: navigationShell),
  branches: [
    _branch(AppRoutes.home, const HomeScreen()),
    _branch(AppRoutes.rewards, const RewardsScreen()),
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

StatefulShellBranch _branch(String path, Widget screen) => StatefulShellBranch(
  routes: [GoRoute(path: path, builder: (context, state) => screen)],
);

/// Home passes its tile's Hero tag as `extra`. A deep link has none.
Widget _productDetail(BuildContext context, GoRouterState state) {
  final id = state.pathParameters['id']!;
  return ProductDetailScreen(
    productId: id,
    heroTag: state.extra ?? productHeroTag(id),
  );
}

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
