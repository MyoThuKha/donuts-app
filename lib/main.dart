import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  LicenseRegistry.addLicense(_fontLicense);
  runApp(const DonutsApp());
}

Stream<LicenseEntry> _fontLicense() async* {
  final licence = await rootBundle.loadString('assets/fonts/OFL.txt');
  yield LicenseEntryWithLineBreaks(['PlusJakartaSans'], licence);
}

/// Placeholder root widget until the router lands.
class DonutsApp extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => context.l10n.appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.light(),
      home: const Scaffold(body: Center(child: Text("J'Donuts"))),
    );
  }
}
