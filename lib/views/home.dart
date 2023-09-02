import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/movie_controller.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/widgets/carousel_slider.dart';
import 'package:movies_app/widgets/custom_title.dart';
import 'package:movies_app/widgets/emphasis_home.dart';
import 'package:movies_app/widgets/pre_load_carousel_slider.dart';
import 'package:movies_app/widgets/pre_load_emphasis_home.dart';

class Home extends StatelessWidget {
  final MovieController controller;

  const Home({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallete.grayDark,
      child: SingleChildScrollView(
        child: Column(
          children: [
            controller.loading
                ? const PreLoadEmphasisHome()
                : EmphasisHome(
                    movie: controller.emphasis,
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
            controller.loading
                ? const PreLoadCarouselSlider()
                : CarouselSlider(item: controller),
          ],
        ),
      ),
    );
  }
}
