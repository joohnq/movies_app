// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter/icons/tabler.dart';
import 'package:movies_app/controller/movies_emphasis_controller.dart';
import 'package:movies_app/controller/movies_popular_controller.dart';
import 'package:movies_app/controller/movies_trending_controller.dart';
import 'package:movies_app/controller/series_emphasis_controller.dart';
import 'package:movies_app/controller/series_popular_controller.dart';
import 'package:movies_app/controller/series_trending_controller.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/views/favourites.dart';
import 'package:movies_app/views/movies.dart';
import 'package:movies_app/views/search.dart';
import 'package:movies_app/views/series.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  final _controllerMoviesPopular = MoviesPopularController();
  final _controllerMoviesTrending = MoviesTrendingController();
  final _controllerMoviesEmphasis = MovieEmphasisController();
  final _controllerSeriesPopular = SeriesPopularController();
  final _controllerSeriesTrending = SeriesTrendingController();
  final _controllerSeriesEmphasis = SeriesEmphasisController();
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    setState(() {
      _controllerMoviesPopular.loading = true;
      _controllerMoviesTrending.movieLoading = true;
      _controllerMoviesEmphasis.moviesEmphasisLoading = true;
      _controllerSeriesPopular.seriesLoading = true;
      _controllerSeriesTrending.seriesLoading = true;
      _controllerSeriesEmphasis.seriesEmphasisLoading = true;
    });

    await _controllerMoviesPopular.fetchPopularMovies(page: lastPage);
    await _controllerMoviesTrending.fetchTrendingMovies(page: lastPage);
    await _controllerMoviesEmphasis.fetchEmphasis(page: lastPage);

    await _controllerSeriesPopular.fetchPopularSeries(page: lastPage);
    await _controllerSeriesTrending.fetchTrendingSeries(page: lastPage);
    await _controllerSeriesEmphasis.fetchSeriesEmphasis(page: lastPage);

    setState(() {
      _controllerMoviesPopular.loading = false;
      _controllerMoviesTrending.movieLoading = false;
      _controllerMoviesEmphasis.moviesEmphasisLoading = false;
      _controllerSeriesPopular.seriesLoading = false;
      _controllerSeriesTrending.seriesLoading = false;
      _controllerSeriesEmphasis.seriesEmphasisLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Home(
        controllerPopular: _controllerMoviesPopular,
        controllerTrending: _controllerMoviesTrending,
        controllerEmphasis: _controllerMoviesEmphasis,
      ),
      Search(
        controllerPopular: _controllerMoviesPopular,
      ),
      Series(
        controllerPopular: _controllerSeriesPopular,
        controllerTrending: _controllerSeriesTrending,
        controllerEmphasis: _controllerSeriesEmphasis,
      ),
      const Favourites(),
    ];

    return Scaffold(
      backgroundColor: Pallete.grayDark,
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          shadowColor: Colors.transparent,
          splashFactory: InkSplash.splashFactory,
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          enableFeedback: true,
          backgroundColor: Pallete.grayDark,
          type: BottomNavigationBarType.fixed,
          unselectedLabelStyle: StyleFont.medium,
          selectedLabelStyle: StyleFont.medium,
          selectedItemColor: Pallete.white,
          unselectedItemColor: Pallete.grayLight,
          elevation: 0,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: "Movies",
              activeIcon: Iconify(
                Mdi.local_movies,
                color: Pallete.white,
                size: 28,
              ),
              icon: Iconify(
                Mdi.local_movies,
                color: Pallete.grayLight,
                size: 28,
              ),
            ),
            BottomNavigationBarItem(
              label: "Search",
              activeIcon: Iconify(
                Tabler.search,
                color: Pallete.white,
                size: 28,
              ),
              icon: Iconify(
                Tabler.search,
                color: Pallete.grayLight,
                size: 28,
              ),
            ),
            BottomNavigationBarItem(
              label: "Series",
              activeIcon: Iconify(
                Ri.movie_fill,
                color: Pallete.white,
                size: 28,
              ),
              icon: Iconify(
                Ri.movie_fill,
                color: Pallete.grayLight,
                size: 28,
              ),
            ),
            BottomNavigationBarItem(
              label: "Favourites",
              activeIcon: Iconify(
                Ri.bookmark_fill,
                color: Pallete.white,
                size: 28,
              ),
              icon: Iconify(
                Ri.bookmark_fill,
                color: Pallete.grayLight,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
