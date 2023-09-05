// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/series_emphasis_controller.dart';
import 'package:movies_app/controller/series_popular_controller.dart';
import 'package:movies_app/controller/series_trending_controller.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/widgets/carousel_slider.dart';
import 'package:movies_app/widgets/custom_title.dart';
import 'package:movies_app/widgets/emphasis_home.dart';
import 'package:movies_app/widgets/pre_load_carousel_slider.dart';
import 'package:movies_app/widgets/pre_load_emphasis_home.dart';

class Series extends StatelessWidget {
  final SeriesTrendingController controllerTrending;
  final SeriesPopularController controllerPopular;
  final SeriesEmphasisController controllerEmphasis;

  const Series({
    super.key,
    required this.controllerPopular,
    required this.controllerTrending,
    required this.controllerEmphasis,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallete.grayDark,
      child: SingleChildScrollView(
        child: Column(
          children: [
            controllerEmphasis.seriesEmphasisLoading
                ? const PreLoadEmphasisHome()
                : EmphasisHome(
                    id: controllerEmphasis.id,
                    backdropPath: controllerEmphasis.backdropPath,
                    originalTitle: controllerEmphasis.originalTitle,
                    title: controllerEmphasis.title,
                    voteAverage: controllerEmphasis.voteAverage,
                  ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTitle(text: "Popular"),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        '/seemore',
                      );
                    },
                    child: Text(
                      "SEE MORE",
                      style: StyleFont.regular.copyWith(color: Pallete.yellow),
                    ),
                  )
                ],
              ),
            ),
            controllerPopular.seriesLoading
                ? const PreLoadCarouselSlider()
                : CarouselSlider<SeriesPopularController>(
                    item: controllerPopular,
                    mediaType: "serie",
                  ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTitle(text: "Trending"),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        '/seemore',
                      );
                    },
                    child: Text(
                      "SEE MORE",
                      style: StyleFont.regular.copyWith(color: Pallete.yellow),
                    ),
                  )
                ],
              ),
            ),
            controllerPopular.seriesLoading
                ? const PreLoadCarouselSlider()
                : CarouselSlider<SeriesTrendingController>(
                    item: controllerTrending,
                    mediaType: "serie",
                  ),
          ],
        ),
      ),
    );
  }
}
