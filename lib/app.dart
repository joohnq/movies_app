import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:iconify_flutter/icons/ri.dart';
import 'package:iconify_flutter/icons/tabler.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/views/favorites.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final List<Widget> screens = [
      const Movies(),
      const Search(),
      const Series(),
      const Favorites(),
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
              label: "Favorites",
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
