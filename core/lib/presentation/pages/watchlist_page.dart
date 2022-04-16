import 'package:core/styles/colors.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:tv/presentation/bloc/tv_watchlist/tv_watchlist_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class WatchlistPage extends StatelessWidget {
  static const routeName = '/watchlist';

  const WatchlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: const Text('Watchlist'),
              pinned: true,
              floating: true,
              bottom: TabBar(
                indicatorColor: kMikadoYellow,
                tabs: [
                  _buildTabBarItem('Movies', Icons.movie_creation_outlined),
                  _buildTabBarItem('TV Series', Icons.live_tv_rounded),
                ],
              ),
            ),
          ];
        },
        body: const TabBarView(
          children: <Widget>[
            WatchlistMoviesPage(),
            WatchlistTvPage(),
          ],
        ),
      )),
    );
  }

  Widget _buildTabBarItem(String title, IconData iconData) => Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData),
            const SizedBox(
              width: 12.0,
            ),
            Text(title),
          ],
        ),
      );
}

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<MovieWatchlistBloc>(context, listen: false)
          .add(FetchMovieWatchlist());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<MovieWatchlistBloc>(context, listen: false)
        .add(FetchMovieWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
          builder: (context, state) {
            if (state is MovieWatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieWatchlistHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                },
                itemCount: state.result.length,
              );
            } else if (state is MovieWatchlistError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}

class WatchlistTvPage extends StatefulWidget {
  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      BlocProvider.of<TvWatchlistBloc>(context, listen: false)
          .add(FetchTvWatchlist());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    BlocProvider.of<TvWatchlistBloc>(context, listen: false)
        .add(FetchTvWatchlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvWatchlistBloc, TvWatchlistState>(
          builder: (context, state) {
            if (state is TvWatchlistLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvWatchlistHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = state.result[index];
                  return TvCard(tv);
                },
                itemCount: state.result.length,
              );
            } else if (state is TvWatchlistError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
