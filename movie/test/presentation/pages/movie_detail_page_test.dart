import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_recommendation/movie_recommendation_bloc.dart';
import 'package:movie/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MovieDetailEventFake extends Fake implements MovieDetailEvent {}

class MovieDetailStateFake extends Fake implements MovieDetailState {}

class MockMovieRecommendationBloc
    extends MockBloc<MovieRecommendationEvent, MovieRecommendationState>
    implements MovieRecommendationBloc {}

class MovieRecommendationEventFake extends Fake
    implements MovieRecommendationEvent {}

class MovieRecommendationStateFake extends Fake
    implements MovieRecommendationState {}

class MockMovieWatchlistBloc
    extends MockBloc<MovieWatchlistEvent, MovieWatchlistState>
    implements MovieWatchlistBloc {}

class MovieWatchlistEventFake extends Fake implements MovieWatchlistEvent {}

class MovieWatchlistStateFake extends Fake implements MovieWatchlistState {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationBloc mockMovieRecommendationBloc;
  late MockMovieWatchlistBloc mockMovieWatchlistBloc;

  setUpAll(() {
    registerFallbackValue(MovieDetailEventFake());
    registerFallbackValue(MovieDetailStateFake());
    registerFallbackValue(MovieRecommendationEventFake());
    registerFallbackValue(MovieRecommendationStateFake());
    registerFallbackValue(MovieWatchlistEventFake());
    registerFallbackValue(MovieWatchlistStateFake());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationBloc = MockMovieRecommendationBloc();
    mockMovieWatchlistBloc = MockMovieWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(create: (context) => mockMovieDetailBloc),
        BlocProvider<MovieRecommendationBloc>(
            create: (context) => mockMovieRecommendationBloc),
        BlocProvider<MovieWatchlistBloc>(
            create: (context) => mockMovieWatchlistBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(const WatchlistHasData(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.state)
        .thenReturn(const MovieDetailHasData(testMovieDetail));
    when(() => mockMovieRecommendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));
    when(() => mockMovieWatchlistBloc.state)
        .thenReturn(const WatchlistHasData(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  // testWidgets(
  //     'Watchlist button should display Snackbar when added to watchlist',
  //     (WidgetTester tester) async {
  //   when(() => mockMovieDetailBloc.state)
  //       .thenReturn(const MovieDetailHasData(testMovieDetail));
  //   when(() => mockMovieRecommendationBloc.state)
  //       .thenReturn(MovieRecommendationHasData(testMovieList));
  //   when(() => mockMovieWatchlistBloc.state)
  //       .thenReturn(const WatchlistHasData(false));
  //   when(() => mockMovieWatchlistBloc.state)
  //       .thenReturn(const WatchlistSuccess('Added to Watchlist'));

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(SnackBar), findsOneWidget);
  //   expect(find.text('Added to Watchlist'), findsOneWidget);
  // });

  // testWidgets(
  //     'Watchlist button should display AlertDialog when add to watchlist failed',
  //     (WidgetTester tester) async {
  //   when(() => mockMovieDetailBloc.state)
  //       .thenReturn(const MovieDetailHasData(testMovieDetail));
  //   when(() => mockMovieRecommendationBloc.state)
  //       .thenReturn(MovieRecommendationHasData(testMovieList));
  //   when(() => mockMovieWatchlistBloc.state)
  //       .thenReturn(const WatchlistHasData(false));
  //   when(() => mockMovieWatchlistBloc.state)
  //       .thenReturn(const WatchlistFailure('Failed'));

  //   final watchlistButton = find.byType(ElevatedButton);

  //   await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

  //   expect(find.byIcon(Icons.add), findsOneWidget);

  //   await tester.tap(watchlistButton);
  //   await tester.pump();

  //   expect(find.byType(AlertDialog), findsOneWidget);
  //   expect(find.text('Failed'), findsOneWidget);
  // });
}
