import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/presentation/bloc/movies_popular/movie_popular_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late MoviePopularBloc moviePopularBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = MoviePopularBloc(mockGetPopularMovies);
  });

  test('initial should be Empty', () {
    expect(moviePopularBloc.state, MoviePopularEmpty());
  });

  group('Now Playing Movies', () {
    blocTest<MoviePopularBloc, MoviePopularState>(
      'Should emit [MoviePopularLoading, MoviePopularHasData] when get popular movie data is successful',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(FetchMoviePopular()),
      expect: () => [
        MoviePopularLoading(),
        MoviePopularHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<MoviePopularBloc, MoviePopularState>(
      'Should emit [MoviePopularLoading, MoviePopularError] when get popular movie data is unsuccessful',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(FetchMoviePopular()),
      expect: () => [
        MoviePopularLoading(),
        const MoviePopularError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}
