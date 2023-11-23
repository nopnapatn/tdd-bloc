import 'package:tdd_bloc/core/usecases/usecases.dart';
import 'package:tdd_bloc/core/utils/typedefs.dart';
import 'package:tdd_bloc/src/on_board/domain/repositories/on_boarding_repository.dart';

class CacheFirstTimer extends UsecaseWithoutParams<void> {
  const CacheFirstTimer(
    this._repository,
  );

  final OnBoardingRepository _repository;

  @override
  ResultFuture<void> call() async => _repository.cacheFirstTimer();
}
