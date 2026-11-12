import 'package:donuts/app/router/app_router.dart';
import 'package:donuts/core/di/locator.dart';
import 'package:donuts/core/l10n/l10n.dart';
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
    return BlocProvider.value(
      value: _session,
      child: MaterialApp.router(
        onGenerateTitle: (context) => context.l10n.appTitle,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.light(),
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
