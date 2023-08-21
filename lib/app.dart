import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/icon_park_outline.dart';
import 'package:iconify_flutter/icons/icon_park_solid.dart';
import 'package:movies_app/models/movies_series.dart';
import 'package:movies_app/service/api_service.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/views/favourites.dart';
import 'package:movies_app/views/home.dart';
import 'package:movies_app/views/search.dart';

MovieService movieService = MovieService();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Future<List<Result>> trending;
  late Future<List<Result>> shortly;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    trending = MovieService.trending(1).then((value) => value.results);
    shortly = MovieService.shortly().then((value) => value.results);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Home(
        trending: trending,
        shortly: shortly,
      ),
      const Search(),
      const Favourites(),
    ];

    return Scaffold(
      backgroundColor: Pallete.grayDark,
      body: IndexedStack(
        index: selectedIndex,
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
          currentIndex: selectedIndex,
          enableFeedback: true,
          backgroundColor: Pallete.grayDark,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              activeIcon: Iconify(
                IconParkSolid.home,
                color: Pallete.white,
                size: 28,
              ),
              icon: Iconify(
                IconParkOutline.home,
                color: Pallete.grayLight,
                size: 28,
              ),
            ),
            BottomNavigationBarItem(
              label: "Search",
              activeIcon: Iconify(
                IconParkSolid.search,
                color: Pallete.white,
                size: 28,
              ),
              icon: Iconify(
                IconParkOutline.search,
                color: Pallete.grayLight,
                size: 28,
              ),
            ),
            BottomNavigationBarItem(
              label: "Bookmark",
              activeIcon: Iconify(
                IconParkSolid.bookmark,
                color: Pallete.white,
                size: 28,
              ),
              icon: Iconify(
                IconParkOutline.bookmark,
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
