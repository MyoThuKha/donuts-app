import 'package:bloc_test/bloc_test.dart';
import 'package:donuts/core/result/app_failure.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_member_summary_use_case.dart';
import 'package:donuts/features/settings/presentation/blocs/settings_member_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/member_fakes.dart';

class _MockWatchMember extends Mock implements WatchMemberSummaryUseCase;

void main() {
  late _MockWatchMember watchMember;

  setUp(() => watchMember = _MockWatchMember());

  blocTest<SettingsMemberCubit, Object?>(
    'emits the member summary from the database',
    setUp: () =>
        when(() => watchMember())
            .thenAnswer((_) => Stream.value(testMemberSummary)),
    build: () => SettingsMemberCubit(watchMember),
    act: (cubit) => cubit.start(),
    expect: () => [testMemberSummary],
  );

  blocTest<SettingsMemberCubit, Object?>(
    'a failed read falls back to no member and reports the failure',
    setUp: () => when(
      () => watchMember(),
    ).thenAnswer((_) => Stream.error(const DatabaseFailure(error: 'disk I/O'))),
    build: () => SettingsMemberCubit(watchMember),
    seed: () => testMemberSummary,
    act: (cubit) => cubit.start(),
    expect: () => [null],
    errors: () => [isA<DatabaseFailure>()],
  );
}
