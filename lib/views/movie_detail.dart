import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/movie_detail_controller.dart';
// import 'package:movies_app/models/movie_detail_model.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/tools/formatting.dart';
import 'package:movies_app/widgets/carousel_movie_images.dart';
import 'package:movies_app/widgets/pre_load_movie_detail.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({Key? key}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final int _id = Get.arguments.id;
  int _current = 0;
  final _controller = MovieDetailController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    setState(() {
      _controller.movieDetailLoading = true;
      _controller.movieImagesLoading = true;
      _controller.movieCreditsLoading = true;
    });

    await _controller.fetchMovieById(_id);
    await _controller.fetchMovieImages(_id);
    await _controller.fetchMovieCredits(_id);

    setState(() {
      _controller.movieDetailLoading = false;
      _controller.movieImagesLoading = false;
      _controller.movieCreditsLoading = false;
    });
  }

  _updateCurrent(index) {
    setState(() {
      _current = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double statusBar = MediaQuery.of(context).padding.top;
    final CarouselController controllerCarousel = CarouselController();
    return Scaffold(
      backgroundColor: Pallete.grayDark,
      body: SingleChildScrollView(
        child: _controller.movieDetailLoading
            ? const PreLoadMovieDetail()
            : Column(
                children: [
                  SizedBox(
                    height: height * 0.6,
                    child: Stack(
                      children: [
                        SizedBox(
                          height: height * 0.4,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: CarouselMovieImages(
                                  images: _controller.images,
                                  current: _current,
                                  controllerImages: _controller,
                                  controllerCarousel: controllerCarousel,
                                  updateCurrent: _updateCurrent,
                                ),
                              ),
                              Positioned(
                                top: statusBar + 10,
                                left: 20,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color:
                                            const Color.fromRGBO(0, 0, 0, 0.7),
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                    child: const Icon(
                                      Icons.keyboard_arrow_left_rounded,
                                      color: Pallete.white,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: (height * 0.3) - 50,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: (height * 0.3) + 50,
                                width: ((height * 0.3) + 50) * 0.64,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://image.tmdb.org/t/p/w780${_controller.posterPath}",
                                  placeholder: (context, url) => Container(
                                    height: height,
                                    width: width,
                                    decoration: const BoxDecoration(
                                      color: Pallete.preLoad,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      width: width,
                                      height: height,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Pallete.grayLight),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.language,
                                          color: Pallete.white,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        AutoSizeText(
                                          _controller.originalLanguage[0]
                                                  .toUpperCase() +
                                              _controller.originalLanguage
                                                  .substring(1),
                                          maxLines: 1,
                                          style: StyleFont.medium
                                              .copyWith(color: Pallete.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (_controller.releaseDate
                                      .toString()
                                      .isNotEmpty)
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 2),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Pallete.grayLight),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.calendar_month,
                                            color: Pallete.white,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            Formating.formatDate(
                                              _controller.releaseDate
                                                  .toString(),
                                            ),
                                            style: StyleFont.medium
                                                .copyWith(color: Pallete.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Pallete.grayLight),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    child: SizedBox(
                                      width: 50,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.star_rounded,
                                            size: 24,
                                            color: Pallete.yellow,
                                          ),
                                          Text(
                                            _controller.voteAverage,
                                            style: StyleFont.bold.copyWith(
                                                color: Pallete.white,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width - 40,
                          child: Text(
                            _controller.originalTitle == ""
                                ? _controller.title
                                : _controller.originalTitle,
                            style: StyleFont.bold
                                .copyWith(color: Pallete.white, fontSize: 24),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _buildCategories(width),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          _controller.overview,
                          style: StyleFont.medium
                              .copyWith(color: Pallete.white, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        _buildCredits(),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  _buildCategories(double width) {
    return SizedBox(
      height: 25,
      width: width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: _controller.genres.take(3).length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Pallete.grayLight,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                _controller.genres[index].name,
                style: StyleFont.bold.copyWith(
                  color: Pallete.white,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildCredits() {
    return _controller.movieCreditsLoading
        ? const CircularProgressIndicator()
        : SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  _controller.cast.length <= 12 ? _controller.cast.length : 12,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/w500${_controller.cast[index].profilePath}",
                        placeholder: (context, url) => Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Pallete.preLoad,
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Pallete.white,
                        ),
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            _controller.cast[index].originalName,
                            style: StyleFont.medium
                                .copyWith(color: Pallete.white, fontSize: 14),
                          ),
                          AutoSizeText(
                            _controller.cast[index].character ?? "",
                            style: StyleFont.medium.copyWith(
                                color: Pallete.grayLight, fontSize: 12),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          );
  }
}
