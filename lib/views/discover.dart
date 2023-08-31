import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/movie_controller.dart';
// import 'package:iconify_flutter/iconify_flutter.dart';
// import 'package:iconify_flutter/icons/tabler.dart';
import 'package:movies_app/models/categories.dart';
import 'package:movies_app/models/movie.dart';
// import 'package:movies_app/models/movie.dart';
// import 'package:movies_app/models/movie_response.dart';
// import 'package:movies_app/service/api_service.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/widgets/custom_title.dart';
import 'package:movies_app/widgets/vertical_card.dart';
// import 'package:movies_app/widgets/pre_load_vertical_card.dart';
// import 'package:movies_app/widgets/vertical_card.dart';

class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  int page = 1;
  int whatIsTrue = 0;
  int lastPage = 1;
  final _controller = MovieController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initialize();
    // _initScrollListener();
  }

  _initScrollListener() async {
    // _scrollController.addListener(() async {
    //   if (_scrollController.offset >=
    //       _scrollController.position.maxScrollExtent) {
    //     if (_controller.currentPage == lastPage) {
    //       lastPage++;
    //       await _controller.fetchPopularMovies(page: lastPage);
    //       setState(() {});
    //     }
    //   }
    // });
    if (_controller.currentPage == lastPage) {
      lastPage++;
      await _controller.fetchPopularMovies(page: lastPage);
      setState(() {});
    }
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
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    // double statusBar = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Pallete.grayDark,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.keyboard_arrow_left_rounded,
                            size: 40,
                            color: Pallete.yellow,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const CustomTitle(text: "Discover"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: index == whatIsTrue
                                  ? Pallete.yellow
                                  : Pallete.grayLight,
                            ),
                            margin: const EdgeInsets.only(right: 10),
                            child: Center(
                              child: Text(
                                categories[index]['name'],
                                style: StyleFont.bold.copyWith(
                                  color: index == whatIsTrue
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
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _controller.loading
                  ? const CircularProgressIndicator()
                  : GridView.builder(
                      controller: _scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 10,
                        childAspectRatio: width * 0.64 / width,
                      ),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _controller.moviesCount,
                      itemBuilder: (context, index) {
                        final List<MovieModel> movie = _controller.movies;
                        return VerticalCard(
                          item: movie[index],
                        );
                      },
                    ),
              GestureDetector(
                onTap: () {
                  _initScrollListener();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Pallete.yellow,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "Mostrar mais",
                      style: StyleFont.bold
                          .copyWith(color: Pallete.grayDark, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
