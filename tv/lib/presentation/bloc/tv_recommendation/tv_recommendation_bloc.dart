import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';

part 'tv_recommendation_event.dart';
part 'tv_recommendation_state.dart';

class TvRecommendationBloc
    extends Bloc<TvRecommendationEvent, TvRecommendationState> {
  final GetTvRecommendations _getTvRecommendations;

  TvRecommendationBloc(this._getTvRecommendations)
      : super(TvRecommendationEmpty()) {
    on<FetchTvRecommendation>((event, emit) async {
      final id = event.id;

      emit(TvRecommendationLoading());

      final recommendationResult = await _getTvRecommendations.execute(id);

      recommendationResult.fold(
        (failure) => emit(TvRecommendationError(failure.message)),
        (data) => emit(TvRecommendationHasData(data)),
      );
    });
  }
}
