import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/presentation/bloc/movies_now_playing/movie_now_playing_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MovieNowPlayingBloc movieNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieNowPlayingBloc = MovieNowPlayingBloc(mockGetNowPlayingMovies);
  });

  test('initial should be Empty', () {
    expect(movieNowPlayingBloc.state, MovieNowPlayingEmpty());
  });

  group('Now Playing Movies', () {
    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'Should emit [MovieNowPlayingLoading, MovieNowPlayingHasData] when get now playing movie data is successful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchMovieNowPlaying()),
      expect: () => [
        MovieNowPlayingLoading(),
        MovieNowPlayingHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'Should emit [MovieNowPlayingLoading, MovieNowPlayingError] when get now playing movie data is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(FetchMovieNowPlaying()),
      expect: () => [
        MovieNowPlayingLoading(),
        const MovieNowPlayingError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });
}
