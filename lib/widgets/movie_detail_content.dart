import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/models/credits.dart';
import 'package:movies_app/models/movie_images.dart';
import 'package:movies_app/models/movies_series.dart';
import 'package:movies_app/service/api_service.dart';
import 'package:movies_app/service/favourites_service.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/widgets/carousel_slider_images.dart';
import 'package:movies_app/widgets/credits.dart';
import 'package:movies_app/widgets/error_component.dart';
import 'package:movies_app/widgets/networks.dart';
import 'package:movies_app/widgets/seasons.dart';

class MovieDetailContent extends StatefulWidget {
  final Result? item;
  final bool itsFavourite;
  final Function(bool) setFavouriteState;
  final Future<List<Backdrop>> images;

  const MovieDetailContent({
    Key? key,
    required this.item,
    required this.itsFavourite,
    required this.setFavouriteState,
    required this.images,
  }) : super(key: key);

  @override
  State<MovieDetailContent> createState() => _MovieDetailContentState();
}

class _MovieDetailContentState extends State<MovieDetailContent> {
  late final Future<CreditsModel> credits;
  bool itsFavourite = false;
  int current = 0;

  @override
  void initState() {
    super.initState();
    credits = MovieService.credits(widget.item!.id);
    itsFavourite = widget.itsFavourite;
  }

  updateCurrent(index) {
    setState(() {
      current = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double statusBar = MediaQuery.of(context).padding.top;
    final CarouselController controller = CarouselController();
    return SingleChildScrollView(
      child: Column(
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
                        child: CarouselSliderImages(
                          images: widget.images,
                          current: current,
                          controller: controller,
                          updateCurrent: updateCurrent,
                        ),
                      ),
                      Positioned(
                        top: statusBar + 10,
                        left: 20,
                        right: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(0, 0, 0, 0.7),
                                    borderRadius: BorderRadius.circular(40)),
                                child: const Icon(
                                  Icons.keyboard_arrow_left_rounded,
                                  color: Pallete.white,
                                  size: 30,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                widget.setFavouriteState(!widget.itsFavourite);
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(0, 0, 0, 0.7),
                                    borderRadius: BorderRadius.circular(40)),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      itsFavourite = !itsFavourite;
                                    });
                                    FavouritesService.changeFavouriteStatus(
                                        json.encode([
                                          widget.item!.id.toString(),
                                          widget.item!.name == ""
                                              ? widget.item!.title
                                              : widget.item!.name ?? '',
                                        ]),
                                        itsFavourite);
                                  },
                                  child: itsFavourite
                                      ? const Icon(
                                          Icons.bookmark_outline_rounded,
                                          size: 30,
                                          color: Pallete.white,
                                        )
                                      : const Icon(
                                          Icons.bookmark,
                                          size: 30,
                                          color: Pallete.white,
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 20,
                  top: (height * 0.3) - 50,
                  child: SizedBox(
                    height: (height * 0.3) + 50,
                    width: ((height * 0.3) + 50) * 0.64,
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://image.tmdb.org/t/p/w780${widget.item!.posterPath}",
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
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width - 40,
                          child: Text(
                            widget.item?.name == ""
                                ? widget.item!.title
                                : widget.item?.name ?? '',
                            style: StyleFont.bold
                                .copyWith(color: Pallete.white, fontSize: 24),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
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
                                  Row(
                                    children: [
                                      Text(
                                        widget.item!.voteAverage
                                            .toStringAsFixed(1),
                                        style: StyleFont.bold.copyWith(
                                            color: Pallete.white, fontSize: 14),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              height: 25,
                              width: width * 0.6,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: widget.item!.genres!.length < 2
                                    ? widget.item!.genres!.length
                                    : 2,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Pallete.grayLight),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Text(
                                        widget.item!.genres![index].name,
                                        style: StyleFont.regular.copyWith(
                                          color: Pallete.grayLight,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Resumo",
                  style: StyleFont.medium.copyWith(
                    color: Pallete.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                widget.item!.overview == ""
                    ? const ErrorComponent()
                    : Text(
                        widget.item!.overview,
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
                Credits(credits: credits),
                const SizedBox(
                  height: 30,
                ),
                if (widget.item!.networks!.isNotEmpty)
                  CustomNetworks(item: widget.item!, totalWidth: width),
                if (widget.item!.seasons!.isNotEmpty)
                  CustomSeasons(item: widget.item!, totalWidth: width)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
