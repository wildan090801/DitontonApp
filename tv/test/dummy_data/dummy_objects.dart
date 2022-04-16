import 'package:tv/data/models/tv_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';

final testTv = Tv(
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

final testTvList = [testTv];

const testTvDetail = TvDetail(
  adult: false,
  backdropPath: 'backdropPath',
  firstAirDate: 'first_air_date',
  lastAirDate: 'last_air_date',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  name: 'name',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  popularity: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTvTable = TvTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};
