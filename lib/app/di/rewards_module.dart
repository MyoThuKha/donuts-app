import 'package:donuts/core/database/app_database.dart';
import 'package:donuts/features/rewards/data/repositories/member_repository_impl.dart';
import 'package:donuts/features/rewards/data/repositories/rewards_repository_impl.dart';
import 'package:donuts/features/rewards/data/sources/reward_claims_memory_source.dart';
import 'package:donuts/features/rewards/domain/repositories/member_repository.dart';
import 'package:donuts/features/rewards/domain/repositories/rewards_repository.dart';
import 'package:donuts/features/rewards/domain/usecases/claim_challenge_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/clear_reward_claims_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_challenges_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_gifts_use_case.dart';
import 'package:donuts/features/rewards/domain/usecases/watch_member_summary_use_case.dart';
import 'package:donuts/features/rewards/presentation/blocs/rewards_cubit.dart';
import 'package:get_it/get_it.dart';

/// The member summary that Home and Rewards read, and the Rewards screen.
void registerRewardsModule(GetIt getIt) {
  getIt
    // Earn claims live for the app's run and are shared by Home and Rewards.
    ..registerLazySingleton(RewardClaimsMemorySource.new)
    ..registerLazySingleton<MemberRepository>(
      () => MemberRepositoryImpl(getIt<AppDatabase>().memberDao, getIt()),
    )
    ..registerLazySingleton(() => WatchMemberSummaryUseCase(getIt()))
    ..registerLazySingleton<RewardsRepository>(
      () => RewardsRepositoryImpl(
        getIt<AppDatabase>().memberDao,
        getIt<AppDatabase>().catalogDao,
        getIt(),
      ),
    )
    ..registerLazySingleton(() => WatchChallengesUseCase(getIt()))
    ..registerLazySingleton(() => WatchGiftsUseCase(getIt()))
    ..registerLazySingleton(() => ClaimChallengeUseCase(getIt()))
    ..registerLazySingleton(() => ClearRewardClaimsUseCase(getIt()))
    ..registerFactory(
      () => RewardsCubit(
        member: getIt(),
        challenges: getIt(),
        gifts: getIt(),
        claim: getIt(),
        clearClaims: getIt(),
      ),
    );
}
