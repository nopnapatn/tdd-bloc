import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_bloc/core/errors/failures.dart';
import 'package:tdd_bloc/src/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:tdd_bloc/src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:tdd_bloc/src/on_boarding/presentation/cubit/on_boarding_cubit.dart';

class MockCacheFirstTimer extends Mock implements CacheFirstTimer {}

class MockCheckIfUserIsFirstTimer extends Mock
    implements CheckIfUserIsFirstTimer {}

void main() {
  late CacheFirstTimer cacheFirstTimer;
  late CheckIfUserIsFirstTimer checkIfUserIsFirstTimer;
  late OnBoardingCubit cubit;

  final tFailure = CacheFailure(
    message: 'Insufficient storage permission',
    statusCode: 4032,
  );

  setUp(() {
    cacheFirstTimer = MockCacheFirstTimer();
    checkIfUserIsFirstTimer = MockCheckIfUserIsFirstTimer();
    cubit = OnBoardingCubit(
      cacheFirstTimer: cacheFirstTimer,
      checkIfUserIsFirstTimer: checkIfUserIsFirstTimer,
    );
  });

  test('initial state should be [OnBoardingInitial]', () async {
    expect(cubit.state, const OnBoardingInitial());
  });

  group('cacheFirstTimer', () {
    blocTest<OnBoardingCubit, OnBoardingState>(
        'should emit [CachingFirstTimer, UserCached] when successful',
        build: () {
          when(
            () => cacheFirstTimer(),
          ).thenAnswer((_) async => const Right(null));
          return cubit;
        },
        act: (cubit) => cubit.cacheFirstTimer(),
        expect: () => const [
              CachingFirstTimer(),
              UserCached(),
            ],
        verify: (_) {
          verify(
            () => const CachingFirstTimer(),
          ).called(1);
          verifyNoMoreInteractions(cacheFirstTimer);
        });

    blocTest<OnBoardingCubit, OnBoardingState>(
        'should emit [CachingFirstTimer, OnBoardingError] when unsuccessful',
        build: () {
          when(
            () => cacheFirstTimer(),
          ).thenAnswer((_) async => Left(tFailure));
          return cubit;
        },
        act: (cubit) => cubit.cacheFirstTimer(),
        expect: () => [
              const CachingFirstTimer(),
              OnBoardingError(tFailure.errorMessage),
            ],
        verify: (_) {
          verify(
            () => const CachingFirstTimer(),
          ).called(1);
          verifyNoMoreInteractions(cacheFirstTimer);
        });
  });
}
