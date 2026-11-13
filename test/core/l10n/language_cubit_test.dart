import 'package:bloc_test/bloc_test.dart';
import 'package:donuts/core/l10n/app_language.dart';
import 'package:donuts/core/l10n/language_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_language_store.dart';

void main() {
  group('AppLanguage.fromCode', () {
    test('maps stored codes back to languages', () {
      expect(AppLanguage.fromCode('my'), AppLanguage.burmese);
      expect(AppLanguage.fromCode('en'), AppLanguage.english);
    });

    test('falls back to the device language', () {
      expect(AppLanguage.fromCode(null), AppLanguage.system);
      expect(AppLanguage.fromCode('fr'), AppLanguage.system);
    });
  });

  group('LanguageCubit', () {
    blocTest<LanguageCubit, AppLanguage>(
      'restore reads the stored language',
      build: () => LanguageCubit(FakeLanguageStore('my')),
      act: (cubit) => cubit.restore(),
      expect: () => [AppLanguage.burmese],
    );

    final store = FakeLanguageStore();
    blocTest<LanguageCubit, AppLanguage>(
      'select switches the language and stores its code',
      build: () => LanguageCubit(store),
      act: (cubit) => cubit.select(AppLanguage.burmese),
      expect: () => [AppLanguage.burmese],
      verify: (_) => expect(store.code, 'my'),
    );

    final cleared = FakeLanguageStore('my');
    blocTest<LanguageCubit, AppLanguage>(
      'selecting the device language clears the stored code',
      build: () => LanguageCubit(cleared),
      seed: () => AppLanguage.burmese,
      act: (cubit) => cubit.select(AppLanguage.system),
      expect: () => [AppLanguage.system],
      verify: (_) => expect(cleared.code, isNull),
    );
  });
}
