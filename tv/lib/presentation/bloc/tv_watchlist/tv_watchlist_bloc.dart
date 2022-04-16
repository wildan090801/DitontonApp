import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv_status.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchlistTv _getTvWatchlist;
  final GetWatchListTvStatus _getWatchListTvStatus;
  final SaveTvWatchlist _saveWatchlist;
  final RemoveTvWatchlist _removeWatchlist;

  TvWatchlistBloc(this._getTvWatchlist, this._getWatchListTvStatus,
      this._saveWatchlist, this._removeWatchlist)
      : super(TvWatchlistEmpty()) {
    on<FetchTvWatchlist>(
      (event, emit) async {
        emit(TvWatchlistLoading());
        final watchlistResult = await _getTvWatchlist.execute();

        watchlistResult.fold(
          (failure) {
            emit(TvWatchlistError(failure.message));
          },
          (data) {
            emit(TvWatchlistHasData(data));
          },
        );
      },
    );
    on<LoadWatchlistStatus>(((event, emit) async {
      final id = event.id;
      final result = await _getWatchListTvStatus.execute(id);

      emit(WatchlistHasData(result));
    }));
    on<AddTvWatchlist>((event, emit) async {
      final tv = event.tv;

      final result = await _saveWatchlist.execute(tv);

      result.fold(
        (failure) => emit(WatchlistFailure(failure.message)),
        (successMessage) => emit(const WatchlistSuccess('Added to Watchlist')),
      );

      add(LoadWatchlistStatus(tv.id));
    });

    on<DeleteTvWatchlist>((event, emit) async {
      final tv = event.tv;

      final result = await _removeWatchlist.execute(tv);
      result.fold(
        (failure) => emit(WatchlistFailure(failure.message)),
        (successMessage) =>
            emit(const WatchlistSuccess('Removed from Watchlist')),
      );
      add(LoadWatchlistStatus(tv.id));
    });
  }
}
