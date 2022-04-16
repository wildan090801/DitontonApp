import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_watchlist/tv_watchlist_bloc.dart';
import 'package:tv/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_recommendation/tv_recommendation_bloc.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:mockito/annotations.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class TvDetailEventFake extends Fake implements TvDetailEvent {}

class TvDetailStateFake extends Fake implements TvDetailState {}

class MockTvRecommendationBloc
    extends MockBloc<TvRecommendationEvent, TvRecommendationState>
    implements TvRecommendationBloc {}

class TvRecommendationEventFake extends Fake implements TvRecommendationEvent {}

class TvRecommendationStateFake extends Fake implements TvRecommendationState {}

class MockTvWatchlistBloc extends MockBloc<TvWatchlistEvent, TvWatchlistState>
    implements TvWatchlistBloc {}

class TvWatchlistEventFake extends Fake implements TvWatchlistEvent {}

class TvWatchlistStateFake extends Fake implements TvWatchlistState {}

@GenerateMocks([TvDetailBloc])
void main() {
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvRecommendationBloc mockTvRecommendationBloc;
  late MockTvWatchlistBloc mockTvWatchlistBloc;

  setUpAll(() {
    registerFallbackValue(TvDetailEventFake());
    registerFallbackValue(TvDetailStateFake());
    registerFallbackValue(TvRecommendationEventFake());
    registerFallbackValue(TvRecommendationStateFake());
    registerFallbackValue(TvWatchlistEventFake());
    registerFallbackValue(TvWatchlistStateFake());
  });

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
    mockTvRecommendationBloc = MockTvRecommendationBloc();
    mockTvWatchlistBloc = MockTvWatchlistBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>(create: (context) => mockTvDetailBloc),
        BlocProvider<TvRecommendationBloc>(
            create: (context) => mockTvRecommendationBloc),
        BlocProvider<TvWatchlistBloc>(create: (context) => mockTvWatchlistBloc),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when tv not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(const TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationBloc.state)
        .thenReturn(TvRecommendationHasData(testTvList));
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(const WatchlistHasData(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.state)
        .thenReturn(const TvDetailHasData(testTvDetail));
    when(() => mockTvRecommendationBloc.state)
        .thenReturn(TvRecommendationHasData(testTvList));
    when(() => mockTvWatchlistBloc.state)
        .thenReturn(const WatchlistHasData(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
