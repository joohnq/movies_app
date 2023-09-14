import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/backdrop_model.dart';
import 'package:movies_app/style/colors.dart';

class CarouselMovieImages<T> extends StatelessWidget {
  final CarouselController controllerCarousel;
  final int current;
  final List<Backdrop> images;
  final int imagesCount;
  final List<Backdrop> items;
  final Function(int) updateCurrent;

  const CarouselMovieImages({
    super.key,
    required this.controllerCarousel,
    required this.current,
    required this.images,
    required this.imagesCount,
    required this.items,
    required this.updateCurrent,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.4;
    double width = MediaQuery.of(context).size.width;
    double statusBar = MediaQuery.of(context).padding.top;

    return imagesCount != 1
        ? SizedBox(
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
                  items: items.take(10).map((i) {
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
                      for (var index = 0; index < imagesCount; index++)
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
          )
        : SizedBox(
            height: height,
            child: Stack(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: height,
                      width: width,
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://image.tmdb.org/t/p/w780${items[0].filePath}",
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
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: height,
                      width: width,
                      decoration:
                          const BoxDecoration(color: Pallete.transparent50),
                    ),
                  ],
                ),
                Positioned(
                  top: statusBar + 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var index = 0; index < imagesCount; index++)
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
