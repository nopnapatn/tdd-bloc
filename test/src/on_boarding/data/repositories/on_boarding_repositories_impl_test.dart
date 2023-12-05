import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_bloc/core/errors/exceptions.dart';
import 'package:tdd_bloc/core/errors/failures.dart';
import 'package:tdd_bloc/src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:tdd_bloc/src/on_boarding/data/repositories/on_boarding_repository_impl.dart';
import 'package:tdd_bloc/src/on_boarding/domain/repositories/on_boarding_repository.dart';

class MockOnBoardingLocalDataSource extends Mock
    implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource localDataSource;
  late OnBaordingRepositoryImpl repositoryImpl;

  setUp(() {
    localDataSource = MockOnBoardingLocalDataSource();
    repositoryImpl = OnBaordingRepositoryImpl(localDataSource);
  });

  test('should be a subclass of [OnBoardingRepository]', () {
    expect(repositoryImpl, isA<OnBoardingRepository>());
  });

  group('cacheFirstTimer', () {
    test('should complete successfully when call to local source is successful',
        () async {
      when(
        () => localDataSource.cacheFirstTimer(),
      ).thenAnswer((_) async => Future.value());

      final result = await repositoryImpl.cacheFirstTimer();

      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => localDataSource.cacheFirstTimer(),
      );
      verifyNoMoreInteractions(localDataSource);
    });

    test(
        'should return [CacheFailure] when call to local source is '
        'unsuccessful', () async {
      when(
        () => localDataSource.cacheFirstTimer(),
      ).thenThrow(const CacheException(message: 'Insufficient storage'));

      final result = await repositoryImpl.cacheFirstTimer();

      expect(
          result,
          Left<CacheFailure, dynamic>(
              CacheFailure(message: 'Insufficient', statusCode: 500)));
      verify(
        () => localDataSource.cacheFirstTimer(),
      );
      verifyNoMoreInteractions(localDataSource);
    });
  });
}
