import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvTopRatedBloc extends MockBloc<TvTopRatedEvent, TvTopRatedState>
    implements TvTopRatedBloc {}

class TvTopRatedEventFake extends Fake implements TvTopRatedEvent {}

class TvTopRatedStateFake extends Fake implements TvTopRatedState {}

void main() {
  late MockTvTopRatedBloc mockTvTopRatedBloc;

  setUpAll(() {
    registerFallbackValue(TvTopRatedEventFake());
    registerFallbackValue(TvTopRatedStateFake());
  });

  setUp(() {
    mockTvTopRatedBloc = MockTvTopRatedBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvTopRatedBloc>.value(
      value: mockTvTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvTopRatedBloc.state).thenReturn(TvTopRatedLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvTopRatedBloc.state)
        .thenReturn(TvTopRatedHasData(testTvList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTvTopRatedBloc.state)
        .thenReturn(const TvTopRatedError('Error Message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
