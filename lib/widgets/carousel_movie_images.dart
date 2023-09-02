import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/controller/movie_detail_controller.dart';
import 'package:movies_app/models/backdrop_model.dart';
import 'package:movies_app/style/colors.dart';

class CarouselMovieImages extends StatelessWidget {
  final List<Backdrop> images;
  final int current;
  final CarouselController controllerCarousel;
  final MovieDetailController controllerImages;
  final Function(int) updateCurrent;

  const CarouselMovieImages({
    super.key,
    required this.images,
    required this.current,
    required this.controllerImages,
    required this.controllerCarousel,
    required this.updateCurrent,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.4;
    double width = MediaQuery.of(context).size.width;
    double statusBar = MediaQuery.of(context).padding.top;

    return controllerImages.movieImagesLoading
        ? const CircularProgressIndicator()
        : SizedBox(
            height: height,
            child: Stack(
              children: [
                CarouselSlider(
                  carouselController: controllerCarousel,
                  options: CarouselOptions(
                      height: height,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        updateCurrent(index);
                      }),
                  items: controllerImages.images.take(10).map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Stack(
                          children: [
                            SizedBox(
                              height: height,
                              width: width,
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://image.tmdb.org/t/p/w780${i.filePath}",
                                placeholder: (context, url) => Container(
                                  height: height,
                                  width: width,
                                  decoration: const BoxDecoration(
                                    color: Pallete.preLoad,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    width: width,
                                    height: height,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              height: height,
                              width: width,
                              decoration: const BoxDecoration(
                                  color: Pallete.transparent50),
                            ),
                          ],
                        );
                      },
                    );
                  }).toList(),
                ),
                Positioned(
                  top: statusBar + 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var index = 0;
                          index < controllerImages.imagesCount;
                          index++)
                        GestureDetector(
                          onTap: () => controllerCarousel.animateToPage(index),
                          child: Container(
                            width: 7,
                            height: 7,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: current == index
                                  ? Pallete.yellow
                                  : Pallete.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
