import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

/// The Settings tab. Only Log out works; it's how the session is tested.
class SettingsScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) => const _SettingsPage();
}

class _SettingsPage extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ColoredBox(
      color: colors.canvas,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.pageGutter),
          children: [
            Text(context.l10n.tabSettings, style: context.text.display),
            const SizedBox(height: AppSpacing.xxl),
            Material(
              color: colors.surface,
              borderRadius: BorderRadius.circular(AppRadii.card),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                minTileHeight: AppSizes.field,
                leading: Icon(LucideIcons.logOut, color: colors.danger),
                title: Text(
                  context.l10n.logOut,
                  style: context.text.body.copyWith(color: colors.danger),
                ),
                onTap: () => _confirmLogOut(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmLogOut(BuildContext context) async {
    final session = context.read<SessionCubit>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => const _LogOutDialog(),
    );
    if (confirmed ?? false) await session.logOut();
  }
}

class _LogOutDialog extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.logOutConfirm, style: context.text.sectionTitle),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            l10n.logOut,
            style: TextStyle(color: context.colors.danger),
          ),
        ),
      ],
    );
  }
}
