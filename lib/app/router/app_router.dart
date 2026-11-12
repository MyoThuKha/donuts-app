import 'package:donuts/app/shell/app_shell.dart';
import 'package:donuts/app/shell/placeholder_tab_screen.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/router/app_routes.dart';
import 'package:go_router/go_router.dart';

GoRouter buildAppRouter({String initialLocation = AppRoutes.home}) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          _placeholderBranch(AppRoutes.home, (l10n) => l10n.tabHome),
          _placeholderBranch(AppRoutes.rewards, (l10n) => l10n.tabReward),
          _placeholderBranch(AppRoutes.explore, (l10n) => l10n.tabExplore),
          _placeholderBranch(AppRoutes.wallet, (l10n) => l10n.tabWallet),
          _placeholderBranch(AppRoutes.settings, (l10n) => l10n.tabSettings),
        ],
      ),
    ],
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
