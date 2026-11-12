import 'package:donuts/app/app.dart';
import 'package:donuts/app/di/di.dart';
import 'package:donuts/core/di/locator.dart';
import 'package:donuts/features/auth/presentation/session/blocs/session_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(_fontLicense);
  await configureDependencies();
  await getIt<SessionCubit>().restore();
  runApp(const DonutsApp());
}

Stream<LicenseEntry> _fontLicense() async* {
  final licence = await rootBundle.loadString('assets/fonts/OFL.txt');
  yield LicenseEntryWithLineBreaks(['PlusJakartaSans'], licence);
}
