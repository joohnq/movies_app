import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/icon_park_outline.dart';
import 'package:iconify_flutter/icons/icon_park_solid.dart';
import 'package:movies_app/controller/movie_controller.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/views/home.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int selectedIndex = 0;
  final _controller = MovieController();
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    setState(() {
      _controller.loading = true;
    });

    await _controller.fetchPopularMovies(page: lastPage);

    setState(() {
      _controller.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Home(
        controller: _controller,
      ),
      // const Search(),
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
          ],
        ),
      ),
    );
  }
}
