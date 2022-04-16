import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/presentation/bloc/tv_popular/tv_popular_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late TvPopularBloc tvPopularBloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    tvPopularBloc = TvPopularBloc(mockGetPopularTv);
  });

  test('initial should be Empty', () {
    expect(tvPopularBloc.state, TvPopularEmpty());
  });

  group('Now Playing Tv', () {
    blocTest<TvPopularBloc, TvPopularState>(
      'Should emit [TvPopularLoading, TvPopularHasData] when get popular tv data is successful',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return tvPopularBloc;
      },
      act: (bloc) => bloc.add(FetchTvPopular()),
      expect: () => [
        TvPopularLoading(),
        TvPopularHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<TvPopularBloc, TvPopularState>(
      'Should emit [TvPopularLoading, TvPopularError] when get popular tv data is unsuccessful',
      build: () {
        when(mockGetPopularTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvPopularBloc;
      },
      act: (bloc) => bloc.add(FetchTvPopular()),
      expect: () => [
        TvPopularLoading(),
        const TvPopularError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );
  });
}
