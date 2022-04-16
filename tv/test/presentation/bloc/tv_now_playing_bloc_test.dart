import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';
import 'package:tv/presentation/bloc/tv_now_playing/tv_now_playing_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late TvNowPlayingBloc tvNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    tvNowPlayingBloc = TvNowPlayingBloc(mockGetNowPlayingTv);
  });

  test('initial should be Empty', () {
    expect(tvNowPlayingBloc.state, TvNowPlayingEmpty());
  });

  group('Now Playing Tv', () {
    blocTest<TvNowPlayingBloc, TvNowPlayingState>(
      'Should emit [TvNowPlayingLoading, TvNowPlayingHasData] when get now playing tv data is successful',
      build: () {
        when(mockGetNowPlayingTv.execute())
            .thenAnswer((_) async => Right(testTvList));
        return tvNowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchTvNowPlaying()),
      expect: () => [
        TvNowPlayingLoading(),
        TvNowPlayingHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      },
    );

    blocTest<TvNowPlayingBloc, TvNowPlayingState>(
      'Should emit [TvNowPlayingLoading, TvNowPlayingError] when get now playing tv data is unsuccessful',
      build: () {
        when(mockGetNowPlayingTv.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return tvNowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchTvNowPlaying()),
      expect: () => [
        TvNowPlayingLoading(),
        const TvNowPlayingError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingTv.execute());
      },
    );
  });
}
