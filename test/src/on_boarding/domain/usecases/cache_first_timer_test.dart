import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_bloc/core/errors/failures.dart';
import 'package:tdd_bloc/src/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:tdd_bloc/src/on_boarding/domain/usecases/cache_first_timer.dart';

import '../repositories/on_boarding_repository.mock.dart';

void main() {
  late OnBoardingRepository repository;
  late CacheFirstTimer usecase;

  setUp(() {
    repository = MockOnBoardingRepository();
    usecase = CacheFirstTimer(repository);
  });

  test(
      'should call the [OnBoardingRepository.cacheFirstTimer] '
      'and return the right data', () async {
    when(
      () => repository.cacheFirstTimer(),
    ).thenAnswer((_) async => Left(ApiFailure(
          message: 'Unknown error occurred',
          statusCode: 500,
        )));

    final result = await usecase();

    expect(
        result,
        equals(Left<Failure, dynamic>(ApiFailure(
          message: 'Unknown error occurred',
          statusCode: 500,
        ))));
    verify(
      () => repository.cacheFirstTimer(),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}
