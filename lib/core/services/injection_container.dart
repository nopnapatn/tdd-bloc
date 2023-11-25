import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_bloc/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:tdd_bloc/src/on_boarding/data/repositories/on_boarding_repository_impl.dart';
import 'package:tdd_bloc/src/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:tdd_bloc/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:tdd_bloc/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:tdd_bloc/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();

  sl
    ..registerFactory(
      () =>
          OnBoardingCubit(cacheFirstTimer: sl(), checkIfUserIsFirstTimer: sl()),
    )
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))
    ..registerLazySingleton<OnBoardingRepository>(
        () => OnBaordingRepositoryImpl(sl()))
    ..registerLazySingleton<OnBoardingLocalDataSource>(
        () => OnBaordingLocalDataSourceImpl(sl()))
    ..registerLazySingleton(() => prefs);
}
