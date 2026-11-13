import 'package:donuts/app/router/app_router.dart';
import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/l10n/app_language.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/l10n/language_cubit.dart';
import 'package:donuts/core/l10n/language_semantics.dart';
import 'package:donuts/core/network/connectivity_cubit.dart';
import 'package:donuts/core/sync/presentation/catalog_sync_cubit.dart';
import 'package:donuts/core/sync/presentation/seed_cubit.dart';
import 'package:donuts/core/theme/app_theme.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

class DonutsApp extends StatefulWidget {
  const new({super.key});

  @override
  State<DonutsApp> createState() => _DonutsAppState();
}

class _DonutsAppState extends State<DonutsApp> {
  final SessionCubit _session = getIt<SessionCubit>();
  late final GoRouter _router = buildAppRouter(session: _session);

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _session),
        BlocProvider.value(value: getIt<ConnectivityCubit>()),
        BlocProvider.value(value: getIt<CatalogSyncCubit>()),
        BlocProvider.value(value: getIt<SeedCubit>()),
        BlocProvider.value(value: getIt<LanguageCubit>()),
      ],
      child: BlocBuilder<LanguageCubit, AppLanguage>(
        builder: (context, language) => MaterialApp.router(
          onGenerateTitle: (context) => context.l10n.appTitle,
          locale: language.locale,
          localizationsDelegates: appLocalizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: AppTheme.light(),
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
          builder: (context, child) =>
              LanguageSemantics(locale: language.locale, child: child!),
        ),
      ),
    );
  }
}
