import 'package:tdd_bloc/core/utils/typedefs.dart';

abstract class OnBoardingRepository {
  const OnBoardingRepository();

  ResultFuture<void> cacheFirstTimer();
  ResultFuture<bool> checkIfUserIsFirstTimer();
}
