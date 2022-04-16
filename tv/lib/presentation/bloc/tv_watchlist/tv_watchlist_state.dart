part of 'tv_watchlist_bloc.dart';

abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object> get props => [];
}

class TvWatchlistEmpty extends TvWatchlistState {}

class TvWatchlistLoading extends TvWatchlistState {}

class TvWatchlistError extends TvWatchlistState {
  final String message;

  const TvWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TvWatchlistHasData extends TvWatchlistState {
  final List<Tv> result;

  const TvWatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}

class WatchlistFailure extends TvWatchlistState {
  final String message;

  const WatchlistFailure(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistSuccess extends TvWatchlistState {
  final String message;

  const WatchlistSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistHasData extends TvWatchlistState {
  final bool isAdded;

  const WatchlistHasData(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}
