import 'package:tdd_bloc/core/usecases/usecases.dart';
import 'package:tdd_bloc/core/utils/typedefs.dart';
import 'package:tdd_bloc/src/on_board/domain/repositories/on_boarding_repository.dart';

class CheckIfUserIsFirstTimer extends UsecaseWithoutParams<bool> {
  const CheckIfUserIsFirstTimer(
    this._repository,
  );

  final OnBoardingRepository _repository;

  @override
  ResultFuture<bool> call() => _repository.checkIfUserIsFirstTimer();
}
