import 'package:flutter/material.dart';
import 'package:movies_app/controller/movies_popular_controller.dart';
import 'package:movies_app/models/movie_and_serie_model.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/widgets/vertical_card.dart';

class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  final _controller = MoviesPopularController();
  final _scrollController = ScrollController();
  int page = 1;
  int whatIsTrue = 0;
  int lastPage = 1;

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
        if (_controller.itemCurrentPage == lastPage) {
          lastPage++;
          await _controller.fetchMovies(page: lastPage);
          setState(() {});
        }
      }
    });
  }

  _initialize() async {
    setState(() {
      _controller.loading = true;
    });

    await _controller.fetchMovies(page: lastPage);

    setState(() {
      _controller.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                itemCount: _controller.itemCount,
                itemBuilder: (context, index) {
                  final MovieAndSerieModel movie = _controller.item[index];
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
    );
  }
}
