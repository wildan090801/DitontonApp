import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_movie_status.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/remove_watchlist_movies.dart';
import 'package:movie/domain/usecases/save_watchlist_movies.dart';
import 'package:movie/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchListMovieStatus,
  SaveMovieWatchlist,
  RemoveMovieWatchlist
])
void main() {
  late MovieWatchlistBloc movieWatchlistBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListMovieStatus mockGetWatchlistMovieStatus;
  late MockSaveMovieWatchlist mockSaveWatchlistMovie;
  late MockRemoveMovieWatchlist mockRemoveWatchlistMovie;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchlistMovieStatus = MockGetWatchListMovieStatus();
    mockSaveWatchlistMovie = MockSaveMovieWatchlist();
    mockRemoveWatchlistMovie = MockRemoveMovieWatchlist();
    movieWatchlistBloc = MovieWatchlistBloc(
        mockGetWatchlistMovies,
        mockGetWatchlistMovieStatus,
        mockSaveWatchlistMovie,
        mockRemoveWatchlistMovie);
  });

  test('initial state should be empty', () {
    expect(movieWatchlistBloc.state, MovieWatchlistEmpty());
  });

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [MovieWatchlistLoading, MovieWatchlistHasData]  when detail data is gotten successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchMovieWatchlist()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [MovieWatchlistLoading, MovieWatchlistError] when detail data is gotten unsuccessfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchMovieWatchlist()),
    expect: () => [
      MovieWatchlistLoading(),
      const MovieWatchlistError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}
