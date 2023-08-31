import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/models/getx_atributes.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';

class EmphasisHome extends StatefulWidget {
  final MovieModel item;

  const EmphasisHome({super.key, required this.item});

  @override
  State<EmphasisHome> createState() => _EmphasisHomeState();
}

class _EmphasisHomeState extends State<EmphasisHome> {
  late bool itsFavourite = false;
  List<String> category = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    double statusBar = MediaQuery.of(context).padding.top;

    return Container(
      height: height * 0.5,
      width: width,
      constraints: const BoxConstraints(maxHeight: 500),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(
            "/moviedetail",
            arguments: GetxAtributes(widget.item.id),
          );
        },
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl:
                  "https://image.tmdb.org/t/p/w780${widget.item.backdropPath}",
              placeholder: (context, url) => Container(
                height: height,
                width: width,
                decoration: const BoxDecoration(
                  color: Pallete.preLoad,
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: width,
                width: width,
                decoration: const BoxDecoration(
                  color: Pallete.preLoad,
                ),
                child: const Center(
                  child: Icon(
                    Icons.image_outlined,
                    size: 50,
                    color: Pallete.grayLight,
                  ),
                ),
              ),
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
            Container(
              height: height,
              width: width,
              decoration: const BoxDecoration(color: Pallete.transparent),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      widget.item.originalTitle,
                      style: StyleFont.bold
                          .copyWith(color: Pallete.white, fontSize: 30),
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 170,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Pallete.yellow,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.info_outline,
                              size: 20,
                              color: Pallete.grayDark,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Informações",
                              style: StyleFont.bold
                                  .copyWith(color: Pallete.grayDark),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: statusBar + 10,
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    decoration: const BoxDecoration(
                      color: Pallete.yellow,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Text(
                      widget.item.voteAverage.toStringAsFixed(1),
                      style: StyleFont.bold
                          .copyWith(color: Pallete.grayDark, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
