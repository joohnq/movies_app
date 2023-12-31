import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movies_app/abstract/base_detail_controller.dart';
import 'package:movies_app/controller/favorites_controller.dart';
import 'package:movies_app/controller/movie_detail_controller.dart';
import 'package:movies_app/controller/serie_detail_controller.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/tools/formatting.dart';
import 'package:movies_app/widgets/carousel_movie_images.dart';
import 'package:movies_app/widgets/networks.dart';
import 'package:movies_app/widgets/pre_load_movie_detail.dart';
import 'package:movies_app/widgets/seasons.dart';
import 'package:provider/provider.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({Key? key}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final int _id = Get.arguments.id;
  final String _title = Get.arguments.title;
  final String _mediaType = Get.arguments.mediaType;
  int _current = 0;
  BaseDetailController? _controller;
  late bool itsMovie;

  @override
  void initState() {
    super.initState();
    itsMovie = _mediaType == "movie" ? true : false;
    _controller = itsMovie ? MovieDetailController() : SerieDetailController();
    _initialize(_controller!);
  }

  _initialize(BaseDetailController controller) async {
    setState(() {
      controller.detailLoading = true;
      controller.imagesLoading = true;
      controller.creditsLoading = true;
    });

    await controller.fetchById(_id, _title);
    await controller.fetchImages(_id);
    await controller.fetchCredits(_id);

    setState(() {
      controller.detailLoading = false;
      controller.imagesLoading = false;
      controller.creditsLoading = false;
    });
  }

  _updateCurrent(index) {
    setState(() {
      _current = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double statusBar = MediaQuery.of(context).padding.top;
    final CarouselController controllerCarousel = CarouselController();
    return Scaffold(
      backgroundColor: Pallete.grayDark,
      body: SingleChildScrollView(
        child: _controller!.detailLoading
            ? const PreLoadMovieDetail()
            : _buildItemDetail(width, height, statusBar, controllerCarousel),
      ),
    );
  }

  _buildItemDetail(double width, double height, double statusBar,
      CarouselController controllerCarousel) {
    return Column(
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
                        images: _controller!.images,
                        current: _current,
                        items: _controller!.images,
                        imagesCount: _controller!.imagesCount,
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
                            color: const Color.fromRGBO(0, 0, 0, 0.7),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Icon(
                            Icons.keyboard_arrow_left_rounded,
                            color: Pallete.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: statusBar + 10,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(0, 0, 0, 0.7),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Consumer<FavoritesProvider>(
                          builder: (context, storedValue, child) {
                            bool itsFavourite =
                                context.read<FavoritesProvider>().itsFavorite(
                                      '{"id": "$_id", "mediaType": "$_mediaType"}',
                                    );
                            return GestureDetector(
                              onTap: () {
                                itsFavourite = !itsFavourite;
                                itsFavourite
                                    ? storedValue.addToFavorites(
                                        '{"id": "$_id", "mediaType": "$_mediaType"}',
                                      )
                                    : storedValue.removeFromFavorites(
                                        '{"id": "$_id", "mediaType": "$_mediaType"}',
                                      );
                              },
                              child: itsFavourite
                                  ? const Icon(
                                      Icons.bookmark,
                                      size: 30,
                                      color: Pallete.white,
                                    )
                                  : const Icon(
                                      Icons.bookmark_border,
                                      size: 30,
                                      color: Pallete.white,
                                    ),
                            );
                          },
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
                    Container(
                      height: (height * 0.3) + 50,
                      width: ((height * 0.3) + 50) * 0.64,
                      constraints: const BoxConstraints(maxWidth: 300.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/w780${_controller!.posterPath}",
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
                                  image: imageProvider, fit: BoxFit.cover),
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
                        if (_controller!.originalLanguage.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              border: Border.all(color: Pallete.grayLight),
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
                                  _controller!.originalLanguage[0]
                                          .toUpperCase() +
                                      _controller!.originalLanguage
                                          .substring(1),
                                  maxLines: 1,
                                  style: StyleFont.medium
                                      .copyWith(color: Pallete.white),
                                ),
                              ],
                            ),
                          ),
                        if (_controller!.releaseDate.toString().isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              border: Border.all(color: Pallete.grayLight),
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
                                    _controller!.releaseDate.toString(),
                                  ),
                                  style: StyleFont.medium
                                      .copyWith(color: Pallete.white),
                                ),
                              ],
                            ),
                          ),
                        if (_controller!.voteAverage.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              border: Border.all(color: Pallete.grayLight),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: SizedBox(
                              width: 50,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 24,
                                    color: Pallete.yellow,
                                  ),
                                  Text(
                                    _controller!.voteAverage,
                                    style: StyleFont.bold.copyWith(
                                        color: Pallete.white, fontSize: 14),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width - 40,
                child: Text(
                  _controller!.originalTitle.isEmpty
                      ? _controller!.originalName.isEmpty
                          ? _controller!.title.isEmpty
                              ? _controller!.name
                              : _controller!.title
                          : _controller!.originalName
                      : _controller!.originalTitle,
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
              if (_controller!.overview.isNotEmpty)
                Column(
                  children: [
                    Text(
                      _controller!.overview,
                      style: StyleFont.medium
                          .copyWith(color: Pallete.white, fontSize: 14),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
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
        if (_controller!.networks.isNotEmpty)
          Networks(
            networks: _controller!.networks,
            width: width,
          ),
        if (_controller!.seasons.isNotEmpty)
          Seasons(
            width: width,
            posterPath: _controller!.posterPath,
            seasons: _controller!.seasons,
          )
      ],
    );
  }

  _buildCategories(double width) {
    return SizedBox(
      height: 25,
      width: width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: _controller!.genres.take(3).length,
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
                _controller!.genres[index].name,
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
    return _controller!.creditsLoading
        ? const CircularProgressIndicator()
        : SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _controller!.cast.length <= 12
                  ? _controller!.cast.length
                  : 12,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/w500${_controller!.cast[index].profilePath}",
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
                            _controller!.cast[index].originalName,
                            style: StyleFont.medium
                                .copyWith(color: Pallete.white, fontSize: 14),
                          ),
                          AutoSizeText(
                            _controller!.cast[index].character ?? "",
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
