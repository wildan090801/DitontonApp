import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/presentation/bloc/tv_top_rated/tv_top_rated_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TvTopRatedBloc tvTopRatedBloc;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    tvTopRatedBloc = TvTopRatedBloc(mockGetTopRatedTv);
  });

  test('initial should be Empty', () {
    expect(tvTopRatedBloc.state, TvTopRatedEmpty());
  });

  group('Now Playing Tv', () {
    blocTest<TvTopRatedBloc, TvTopRatedState>(
      'Should emit [TvTopRatedLoading, TvTopRatedHasData] when get top rated tv data is successful',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTvTopRated()),
      expect: () => [
        TvTopRatedLoading(),
        TvTopRatedHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest<TvTopRatedBloc, TvTopRatedState>(
      'Should emit [TvTopRatedLoading, TvTopRatedError] when get top rated tv data is unsuccessful',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchTvTopRated()),
      expect: () => [
        TvTopRatedLoading(),
        const TvTopRatedError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );
  });
}
