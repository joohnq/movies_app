import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/abstract/base_movie_and_serie_controller.dart';
import 'package:movies_app/controller/movies_popular_controller.dart';
import 'package:movies_app/controller/series_popular_controller.dart';
import 'package:movies_app/core/categories.dart';
import 'package:movies_app/models/movie_and_serie_model.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/widgets/vertical_card.dart';

class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  final String _mediaType = Get.arguments.mediaType;
  late BaseMovieAndSerieController _controller;
  final _scrollController = ScrollController();
  int page = 1;
  int whatIsTrue = 0;
  int lastPage = 1;
  int selectedItem = 0;

  @override
  void initState() {
    super.initState();
    _mediaType == "movie"
        ? _controller = MoviesPopularController()
        : _controller = SeriesPopularController();
    _initialize();
    _initScrollListener();
  }

  _initScrollListener() async {
    _scrollController.addListener(() async {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent - 400) {
        if (_controller.itemCurrentPage == lastPage) {
          lastPage++;
          await _controller.fetchItems(page: lastPage);
          setState(() {});
        }
      }
    });
  }

  _initialize() async {
    setState(() {
      _controller.loading = true;
    });

    await _controller.fetchItems(page: lastPage);

    setState(() {
      _controller.loading = false;
    });
  }

  _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  _changeSelectedIndex(int index) {
    setState(() {
      selectedItem = index;
    });
    _scrollToTop();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double statusBar = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Pallete.grayDark,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: height * 0.07,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                padding: const EdgeInsets.only(left: 20, right: 10),
                itemBuilder: (context, index) {
                  Map<dynamic, dynamic> item = categories[index];
                  return GestureDetector(
                    onTap: () {
                      _changeSelectedIndex(index);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: selectedItem == index
                            ? Pallete.yellow
                            : Pallete.grayLight,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 0),
                      child: Center(
                        child: Text(
                          "${item['name']}",
                          style: StyleFont.bold.copyWith(
                            color: selectedItem == index
                                ? Pallete.grayDark
                                : Pallete.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: height * 0.93 - statusBar - 30,
              child: _controller.loading
                  ? const CircularProgressIndicator()
                  : GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 10,
                        childAspectRatio: width * 0.64 / width,
                      ),
                      shrinkWrap: true,
                      itemCount: _controller.itemCount,
                      itemBuilder: (context, index) {
                        final MovieAndSerieModel movie =
                            _controller.item[index];
                        return VerticalCard(
                          id: movie.id,
                          mediaType: movie.mediaType,
                          posterPath: movie.posterPath,
                          title: movie.originalTitle.isEmpty
                              ? movie.title.isEmpty
                                  ? movie.name
                                  : movie.title
                              : movie.originalName,
                          voteAverage: movie.voteAverage,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
