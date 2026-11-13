import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_dimens.dart';
import 'package:donuts/core/theme/theme_context.dart';
import 'package:donuts/features/auth/domain/age.dart';
import 'package:donuts/features/auth/domain/vo/user_vo.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_state.dart';
import 'package:donuts/features/settings/presentation/blocs/settings_member_cubit.dart';
import 'package:donuts/features/settings/presentation/items/settings_row_item.dart';
import 'package:donuts/features/settings/presentation/views/settings_header_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Reads the app's version, such as `1.0.0`.
typedef VersionReader = Future<String> Function();

Future<String> _platformVersion() async =>
    (await PackageInfo.fromPlatform()).version;

/// The Settings tab: the member's header on their tier's backdrop, their
/// date of birth and age, Log out and the app version. It runs edge to edge
/// under the status bar.
class SettingsScreen extends StatelessWidget {
  const new({
    this.now = DateTime.now,
    this.readVersion = _platformVersion,
    super.key,
  });

  /// Today's date, for the age. Tests pass a fixed one.
  final DateTime Function() now;

  final VersionReader readVersion;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt<SettingsMemberCubit>()..start(),
    child: _SettingsPage(now: now, readVersion: readVersion),
  );
}

class _SettingsPage extends StatelessWidget {
  const new({required this.now, required this.readVersion});

  final DateTime Function() now;
  final VersionReader readVersion;

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionCubit>().state;
    final user = switch (session) {
      SessionSignedIn(:final user) => user,
      SessionSignedOut() => null,
    };
    final insets = MediaQuery.paddingOf(context);
    return ColoredBox(
      color: context.colors.surface,
      child: CustomScrollView(
        // Bouncing on both platforms, so a pull stretches the blue header.
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          if (user != null) ...[
            SettingsHeaderView(user: user),
            SliverPadding(
              padding: const EdgeInsets.only(top: AppSpacing.l),
              sliver: SliverList.list(children: _details(context, user)),
            ),
          ] else
            SliverToBoxAdapter(child: SizedBox(height: insets.top)),
          SliverToBoxAdapter(
            child: SettingsRowItem(
              icon: LucideIcons.logOut,
              label: context.l10n.logOut,
              filledIcon: true,
              onTap: () => _confirmLogOut(context),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              top: AppSpacing.xxl,
              bottom: insets.bottom + AppSpacing.xl,
            ),
            sliver: SliverToBoxAdapter(
              child: _VersionFooter(readVersion: readVersion),
            ),
          ),
        ],
      ),
    );
  }

  /// The sign-up details the header leaves out.
  List<Widget> _details(BuildContext context, UserVO user) {
    final l10n = context.l10n;
    final age = ageOn(today: now(), birthday: user.dateOfBirth);
    return [
      SettingsRowItem(
        icon: LucideIcons.cake,
        label: l10n.accountDateOfBirth,
        value: DateFormat.yMMMMd(
          Localizations.localeOf(context).toLanguageTag(),
        ).format(user.dateOfBirth),
      ),
      SettingsRowItem(
        icon: LucideIcons.calendarDays,
        label: l10n.accountAge,
        value: l10n.accountAgeYears(age),
      ),
    ];
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

/// "J'Donuts 1.0.0", centred in grey. Shows nothing if the version can't be
/// read.
class _VersionFooter extends StatefulWidget {
  const new({required this.readVersion});

  final VersionReader readVersion;

  @override
  State<_VersionFooter> createState() => _VersionFooterState();
}

class _VersionFooterState extends State<_VersionFooter> {
  late final Future<String> _version = widget.readVersion();

  @override
  Widget build(BuildContext context) => FutureBuilder<String>(
    future: _version,
    builder: (context, snapshot) {
      final version = snapshot.data;
      if (version == null) return const SizedBox.shrink();
      return Text(
        context.l10n.settingsVersion(version),
        textAlign: TextAlign.center,
        style: context.text.label.copyWith(color: context.colors.inkSubtle),
      );
    },
  );
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
