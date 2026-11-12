import 'package:donuts/app/app.dart';
import 'package:donuts/app/bootstrap.dart';
import 'package:donuts/app/di/di.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(_fontLicense);
  await configureDependencies();
  await bootstrap();
  runApp(const DonutsApp());
}

Stream<LicenseEntry> _fontLicense() async* {
  final licence = await rootBundle.loadString('assets/fonts/OFL.txt');
  yield LicenseEntryWithLineBreaks(['PlusJakartaSans'], licence);
}
