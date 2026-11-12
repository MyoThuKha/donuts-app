import 'package:donuts/app/shell/widgets/app_bottom_nav.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// Hosts the five tabs and the bottom navigation bar.
class AppShell extends StatelessWidget {
  const new({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: navigationShell,
      extendBody: true,
      bottomNavigationBar: AppBottomNav(
        currentIndex: navigationShell.currentIndex,
        onSelected: _onSelected,
        items: [
          (icon: LucideIcons.house, label: l10n.tabHome),
          (icon: LucideIcons.crown, label: l10n.tabReward),
          (icon: LucideIcons.target, label: l10n.tabExplore),
          (icon: LucideIcons.wallet, label: l10n.tabWallet),
          (icon: LucideIcons.settings, label: l10n.tabSettings),
        ],
      ),
    );
  }

  void _onSelected(int index) => navigationShell.goBranch(
    index,
    initialLocation: index == navigationShell.currentIndex,
  );
}
