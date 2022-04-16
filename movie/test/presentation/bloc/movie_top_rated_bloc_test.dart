import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/movies_top_rated/movie_top_rated_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MovieTopRatedBloc movieTopRatedBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc = MovieTopRatedBloc(mockGetTopRatedMovies);
  });

  test('initial should be Empty', () {
    expect(movieTopRatedBloc.state, MovieTopRatedEmpty());
  });

  group('Now Playing Movies', () {
    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'Should emit [MovieTopRatedLoading, MovieTopRatedHasData] when get top rated movie data is successful',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchMovieTopRated()),
      expect: () => [
        MovieTopRatedLoading(),
        MovieTopRatedHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'Should emit [MovieTopRatedLoading, MovieTopRatedError] when get top rated movie data is unsuccessful',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(FetchMovieTopRated()),
      expect: () => [
        MovieTopRatedLoading(),
        const MovieTopRatedError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
