import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_now_playing_tv.dart';

part 'tv_now_playing_event.dart';
part 'tv_now_playing_state.dart';

class TvNowPlayingBloc extends Bloc<TvNowPlayingEvent, TvNowPlayingState> {
  final GetNowPlayingTv _getNowPlayingTv;

  TvNowPlayingBloc(this._getNowPlayingTv) : super(TvNowPlayingEmpty()) {
    on<FetchTvNowPlaying>(
      (event, emit) async {
        emit(TvNowPlayingLoading());

        final nowPlayingResult = await _getNowPlayingTv.execute();

        nowPlayingResult.fold(
          (failure) {
            emit(TvNowPlayingError(failure.message));
          },
          (data) {
            emit(TvNowPlayingHasData(data));
          },
        );
      },
    );
  }
}
