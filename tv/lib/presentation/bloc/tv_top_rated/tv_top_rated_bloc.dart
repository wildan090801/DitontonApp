import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';

part 'tv_top_rated_event.dart';
part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final GetTopRatedTv _getTopRatedTv;

  TvTopRatedBloc(this._getTopRatedTv) : super(TvTopRatedEmpty()) {
    on<FetchTvTopRated>(
      (event, emit) async {
        emit(TvTopRatedLoading());

        final topRatedResult = await _getTopRatedTv.execute();

        topRatedResult.fold(
          (failure) {
            emit(TvTopRatedError(failure.message));
          },
          (data) {
            emit(TvTopRatedHasData(data));
          },
        );
      },
    );
  }
}
