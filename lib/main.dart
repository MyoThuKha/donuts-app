import 'package:donuts/app/app.dart';
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
