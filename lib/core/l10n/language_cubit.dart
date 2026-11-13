import 'dart:async';

import 'package:donuts/core/l10n/app_language.dart';
import 'package:donuts/core/storage/language_store.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The app's language. `DonutsApp` passes its locale to `MaterialApp`.
class LanguageCubit extends Cubit<AppLanguage> {
  new(this._store) : super(AppLanguage.system);

  final LanguageStore _store;

  /// Loads the stored choice. `bootstrap` awaits it before the first frame,
  /// so the app never flashes the device language first.
  Future<void> restore() async =>
      emit(AppLanguage.fromCode(await _store.readCode()));

  /// Switches the app to [language] at once, then stores it.
  Future<void> select(AppLanguage language) async {
    if (language == state) return;
    emit(language);
    await _store.writeCode(language.code);
  }
}
