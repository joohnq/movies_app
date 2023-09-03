import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter/icons/tabler.dart';
import 'package:movies_app/controller/emphasis_controller.dart';
import 'package:movies_app/controller/movies_popular_controller.dart';
import 'package:movies_app/controller/movies_trending_controller.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/views/home.dart';
import 'package:movies_app/views/search.dart';
import 'package:movies_app/views/series.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int selectedIndex = 0;
  final _controllerPopular = MoviesPopularController();
  final _controllerTrending = MoviesTrendingController();
  final _controllerEmphasis = EmphasisController();
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    setState(() {
      _controllerPopular.loading = true;
      _controllerTrending.loading = true;
      _controllerEmphasis.loading = true;
    });

    await _controllerPopular.fetchPopularMovies(page: lastPage);
    await _controllerTrending.fetchTrendingMovies(page: lastPage);
    await _controllerEmphasis.fetchEmphasis(page: lastPage);

    setState(() {
      _controllerPopular.loading = false;
      _controllerTrending.loading = false;
      _controllerEmphasis.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final List<Widget> screens = [
      Home(
        controllerPopular: _controllerPopular,
        controllerTrending: _controllerTrending,
        controllerEmphasis: _controllerEmphasis,
      ),
      const Search(),
      Series(
        controllerPopular: _controllerPopular,
        controllerTrending: _controllerTrending,
        controllerEmphasis: _controllerEmphasis,
      ),
      const Search(),
    ];

    return Scaffold(
      backgroundColor: Pallete.grayDark,
      body: _controllerTrending.hasMovies ||
              _controllerPopular.hasMovies ||
              _controllerEmphasis.hasEmphasis
          ? IndexedStack(
              index: selectedIndex,
              children: screens,
            )
          : Scaffold(
              backgroundColor: Pallete.grayDark,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Iconify(
                      Tabler.error_404,
                      size: width * 0.5,
                      color: Pallete.white,
                    ),
                    AutoSizeText(
                      'Erro ao conectar-se com o servidor',
                      maxLines: 2,
                      maxFontSize: 24,
                      minFontSize: 18,
                      style: StyleFont.bold.copyWith(color: Pallete.white),
                    ),
                    AutoSizeText(
                      'Tente novamente mais tarde!',
                      maxLines: 2,
                      maxFontSize: 24,
                      minFontSize: 18,
                      style: StyleFont.bold.copyWith(color: Pallete.white),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          shadowColor: Colors.transparent,
          splashFactory: InkSplash.splashFactory,
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
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
              selectedIndex = index;
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
