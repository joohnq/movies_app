import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/movie_images.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/widgets/future_prompt.dart';
import 'package:movies_app/widgets/pre_load_carousel_slider.dart';

class CarouselSliderImages extends StatefulWidget {
  final Future<List<Backdrop>> images;
  final int current;
  final CarouselController controller;
  final Function(int) updateCurrent;

  const CarouselSliderImages({
    super.key,
    required this.images,
    required this.current,
    required this.controller,
    required this.updateCurrent,
  });

  @override
  State<CarouselSliderImages> createState() => _CarouselSliderImagesState();
}

class _CarouselSliderImagesState extends State<CarouselSliderImages> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.4;
    double width = MediaQuery.of(context).size.width;
    double statusBar = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: height,
      child: FutureBuilder<List<Backdrop>>(
        future: widget.images,
        builder:
            (BuildContext context, AsyncSnapshot<List<Backdrop>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const PreLoadCarouselSlider();
          } else if (snapshot.hasError) {
            return CustomFuturePrompt(text: "Ocorreu um erro: $snapshot.error");
          } else if (!snapshot.hasData) {
            return const CustomFuturePrompt(text: "Nenhum dado encontrado");
          }

          List<Backdrop> items = snapshot.data!.take(10).toList();

          return Stack(
            children: [
              CarouselSlider(
                carouselController: widget.controller,
                options: CarouselOptions(
                    height: height,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      widget.updateCurrent(index);
                    }),
                items: items.map((i) {
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
                    for (var index = 0; index < items.length; index++)
                      GestureDetector(
                        onTap: () => widget.controller.animateToPage(index),
                        child: Container(
                          width: 7,
                          height: 7,
                          margin:
                          const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: widget.current == index
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
          );
        },
      ),
    );
  }
}
