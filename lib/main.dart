import 'package:donuts/app/app.dart';
import 'package:donuts/app/bootstrap.dart';
import 'package:donuts/app/di/di.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(_fontLicenses);
  await configureDependencies();
  await bootstrap();
  runApp(const DonutsApp());
}

Stream<LicenseEntry> _fontLicenses() async* {
  final schibsted = await rootBundle.loadString(
    'assets/fonts/schibsted_grotesk/OFL.txt',
  );
  yield LicenseEntryWithLineBreaks(['SchibstedGrotesk'], schibsted);
  final nunito = await rootBundle.loadString('assets/fonts/nunito/OFL.txt');
  yield LicenseEntryWithLineBreaks(['Nunito'], nunito);
}
