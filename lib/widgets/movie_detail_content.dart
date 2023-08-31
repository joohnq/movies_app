// ignore_for_file: avoid_print

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/formatting.dart';
import 'package:movies_app/models/genre.dart';
import 'package:movies_app/models/movie_detail.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/widgets/error_component.dart';

class MovieDetailContent extends StatefulWidget {
  final MovieDetailModel? item;
  // final Future<List<Backdrop>> images;

  const MovieDetailContent({
    Key? key,
    required this.item,
    // required this.images,
  }) : super(key: key);

  @override
  State<MovieDetailContent> createState() => _MovieDetailContentState();
}

class _MovieDetailContentState extends State<MovieDetailContent> {
  int current = 0;

  @override
  void initState() {
    super.initState();
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
    MovieDetailModel item = widget.item!;
    List<Genre> categoriesMovie = item.genres;
    // final CarouselController controller = CarouselController();
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
                      // Positioned(
                      //   top: 0,
                      //   left: 0,
                      //   right: 0,
                      //   child: CarouselSliderImages(
                      //     images: [],
                      //     current: current,
                      //     controller: controller,
                      //     updateCurrent: updateCurrent,
                      //   ),
                      // ),
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
                                borderRadius: BorderRadius.circular(40)),
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
                              "https://image.tmdb.org/t/p/w780${item.posterPath}",
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
                                  Formating.formatCapitalize(
                                      item.originalLanguage),
                                  maxLines: 1,
                                  style: StyleFont.medium
                                      .copyWith(color: Pallete.white),
                                ),
                              ],
                            ),
                          ),
                          if (item.releaseDate.toString().isNotEmpty)
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
                                    item.releaseDate.toString(),
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
                                    item.voteAverage.toStringAsFixed(1),
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
                    item.title == "" ? item.title : "",
                    style: StyleFont.bold
                        .copyWith(color: Pallete.white, fontSize: 24),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 25,
                  width: width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categoriesMovie.take(3).length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Pallete.grayLight,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            categoriesMovie[index].name,
                            style: StyleFont.bold.copyWith(
                              color: Pallete.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                item.overview == ""
                    ? const ErrorComponent()
                    : Text(
                        item.overview,
                        style: StyleFont.medium
                            .copyWith(color: Pallete.white, fontSize: 14),
                      ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.only(left: 20),
          //   child: Column(
          //     children: [
          //       CustomCredits(credits: widget.item!.credits!),
          //       const SizedBox(
          //         height: 30,
          //       ),
          //       if (item.networks!.isNotEmpty)
          //         CustomNetworks(networks: item.networks!, totalWidth: width),
          //       if (item.seasons!.isNotEmpty)
          //         CustomSeasons(seasons: item.seasons!, totalWidth: width)
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
