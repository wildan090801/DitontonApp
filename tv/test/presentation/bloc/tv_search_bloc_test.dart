import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/search_tv.dart';
import 'package:tv/presentation/bloc/tv_search/search_bloc.dart';

import 'tv_search_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late SearchTvBloc searchTvBloc;
  late MockSearchTv mockSearchTv;

  setUp(() {
    mockSearchTv = MockSearchTv();
    searchTvBloc = SearchTvBloc(mockSearchTv);
  });

  final tTvModel = Tv(
    backdropPath: '/wvdWb5kTQipdMDqCclC6Y3zr4j3.jpg',
    genreIds: const [10759, 18, 10765],
    id: 1402,
    overview:
        'Sheriff\'s deputy Rick Grimes awakens from a coma to find a post-apocalyptic world dominated by flesh-eating zombies. He sets out to find his family and encounters many other survivors along the way.',
    popularity: 1832.419,
    posterPath: '/xf9wuDcqlUPWABZNeDKPbZUjWx0.jpg',
    firstAirDate: '2010-10-31',
    name: 'The Walking Dead',
    originalName: 'The Walking Dead',
    voteAverage: 8.1,
    voteCount: 12859,
  );
  final tTvList = <Tv>[tTvModel];
  const tQuery = 'the walking dead';

  test('initial state should be empty', () {
    expect(searchTvBloc.state, SearchEmpty());
  });

  blocTest<SearchTvBloc, SearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );

  blocTest<SearchTvBloc, SearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      const SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );
}
