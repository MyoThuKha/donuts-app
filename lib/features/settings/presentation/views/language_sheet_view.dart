import 'dart:async';

import 'package:donuts/core/l10n/app_language.dart';
import 'package:donuts/core/l10n/l10n.dart';
import 'package:donuts/core/l10n/language_cubit.dart';
import 'package:donuts/features/settings/presentation/items/language_option_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

/// The language choices. Picking one switches the app and closes the sheet.
class LanguageSheetView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    // The sheet route adds the title, padding and safe area.
    final current = context.watch<LanguageCubit>().state;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final language in AppLanguage.values)
          LanguageOptionItem(
            label: language.label(context.l10n),
            locale: language.locale ?? Localizations.localeOf(context),
            selected: language == current,
            onTap: () => _select(context, language),
          ),
      ],
    );
  }

  void _select(BuildContext context, AppLanguage language) {
    final cubit = context.read<LanguageCubit>();
    Navigator.of(context).pop();
    unawaited(cubit.select(language));
  }
}
