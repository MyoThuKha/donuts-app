import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/features/rewards/data/repositories/member_repository_impl.dart';
import 'package:donuts/features/rewards/domain/repositories/member_repository.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_member_summary_use_case.dart';
import 'package:get_it/get_it.dart';

/// The member summary that Home and Rewards read, and the Rewards screen.
void registerRewardsModule(GetIt getIt) {
  getIt
    ..registerLazySingleton<MemberRepository>(
      () => MemberRepositoryImpl(getIt<AppDatabase>().memberDao),
    )
    ..registerLazySingleton(() => WatchMemberSummaryUseCase(getIt()));
}
