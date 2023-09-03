import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/emphasis_controller.dart';
import 'package:movies_app/controller/movies_popular_controller.dart';
import 'package:movies_app/controller/movies_trending_controller.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/widgets/carousel_slider.dart';
import 'package:movies_app/widgets/custom_title.dart';
import 'package:movies_app/widgets/emphasis_home.dart';
import 'package:movies_app/widgets/pre_load_carousel_slider.dart';
import 'package:movies_app/widgets/pre_load_emphasis_home.dart';

class Series extends StatelessWidget {
  final MoviesTrendingController controllerTrending;
  final MoviesPopularController controllerPopular;
  final EmphasisController controllerEmphasis;

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
            controllerEmphasis.loading
                ? const PreLoadEmphasisHome()
                : EmphasisHome(
                    controller: controllerEmphasis,
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
            controllerPopular.loading
                ? const PreLoadCarouselSlider()
                : CarouselSlider<MoviesPopularController>(
                    item: controllerPopular),
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
            controllerPopular.loading
                ? const PreLoadCarouselSlider()
                : CarouselSlider<MoviesTrendingController>(
                    item: controllerTrending),
          ],
        ),
      ),
    );
  }
}
