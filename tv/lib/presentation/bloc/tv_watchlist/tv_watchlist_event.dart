part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistEvent extends Equatable {
  const TvWatchlistEvent();

  @override
  List<Object> get props => [];
}

class FetchTvWatchlist extends TvWatchlistEvent {}

class AddTvWatchlist extends TvWatchlistEvent {
  final TvDetail tv;

  const AddTvWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class DeleteTvWatchlist extends TvWatchlistEvent {
  final TvDetail tv;

  const DeleteTvWatchlist(this.tv);

  @override
  List<Object> get props => [tv];
}

class LoadWatchlistStatus extends TvWatchlistEvent {
  final int id;

  const LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
