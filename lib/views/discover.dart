import 'package:flutter/material.dart';
import 'package:movies_app/controller/movies_popular_controller.dart';
import 'package:movies_app/models/movie_model.dart';
// import 'package:movies_app/models/movie_model.dart';
// import 'package:movies_app/models/movie_response_model.dart';
// import 'package:movies_app/service/api_service.dart';
import 'package:movies_app/style/colors.dart';
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
  final _controller = MoviesPopularController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initialize();
    _initScrollListener();
  }

  _initScrollListener() async {
    _scrollController.addListener(() async {
      if (_scrollController.offset >=
          _scrollController.position.maxScrollExtent - 400) {
        if (_controller.currentPage == lastPage) {
          lastPage++;
          await _controller.fetchPopularMovies(page: lastPage);
          setState(() {});
        }
      }
    });
    // if (_controller.currentPage == lastPage) {
    //   lastPage++;
    //   await _controller.fetchPopularMovies(page: lastPage);
    //   setState(() {});
    // }
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
        child: _controller.loading
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
                itemCount: _controller.moviesCount,
                itemBuilder: (context, index) {
                  final List<MovieModel> movie = _controller.movies;
                  return VerticalCard(
                    item: movie[index],
                  );
                },
              ),
      ),
    );
  }
}
