import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/presentation/bloc/tv_recommendation/tv_recommendation_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import 'tv_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late TvRecommendationBloc tvRecommendationBloc;
  late MockGetTvRecommendations mockGetTvRecommendation;

  setUp(() {
    mockGetTvRecommendation = MockGetTvRecommendations();
    tvRecommendationBloc = TvRecommendationBloc(mockGetTvRecommendation);
  });

  const tId = 1;

  test('initial state should be empty', () {
    expect(tvRecommendationBloc.state, TvRecommendationEmpty());
  });

  blocTest<TvRecommendationBloc, TvRecommendationState>(
    'Should emit [TvRecommendationLoading, TvRecommendationHasData]  when recommendation data is gotten successfully',
    build: () {
      when(mockGetTvRecommendation.execute(tId))
          .thenAnswer((_) async => Right(testTvList));
      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchTvRecommendation(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvRecommendationLoading(),
      TvRecommendationHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendation.execute(tId));
    },
  );

  blocTest<TvRecommendationBloc, TvRecommendationState>(
    'Should emit [TvRecommendationLoading, TvRecommendationError] when recommendation data is gotten unsuccessfully',
    build: () {
      when(mockGetTvRecommendation.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvRecommendationBloc;
    },
    act: (bloc) => bloc.add(const FetchTvRecommendation(tId)),
    expect: () => [
      TvRecommendationLoading(),
      const TvRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendation.execute(tId));
    },
  );
}
