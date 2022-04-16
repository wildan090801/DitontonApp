import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_popular/tv_popular_bloc.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvPopularBloc extends MockBloc<TvPopularEvent, TvPopularState>
    implements TvPopularBloc {}

class TvPopularEventFake extends Fake implements TvPopularEvent {}

class TvPopularStateFake extends Fake implements TvPopularState {}

void main() {
  late MockTvPopularBloc mockTvPopularBloc;

  setUpAll(() {
    registerFallbackValue(TvPopularEventFake());
    registerFallbackValue(TvPopularStateFake());
  });

  setUp(() {
    mockTvPopularBloc = MockTvPopularBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvPopularBloc>.value(
      value: mockTvPopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvPopularBloc.state).thenReturn(TvPopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvPopularBloc.state)
        .thenReturn(TvPopularHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTvPopularBloc.state)
        .thenReturn(const TvPopularError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
