import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:movies_app/models/movie_and_serie_model.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';

class HorizontalCard extends StatefulWidget {
  final MovieAndSerieModel item;

  const HorizontalCard({super.key, required this.item});

  @override
  State<HorizontalCard> createState() => _HorizontalCardState();
}

class _HorizontalCardState extends State<HorizontalCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;
    final voteAverage = widget.item.voteAverage / 2;

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          'moviedetail',
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://image.tmdb.org/t/p/w780${widget.item.backdropPath}",
                    placeholder: (context, url) => Container(
                      height: 130,
                      width: width / 2,
                      decoration: const BoxDecoration(
                        color: Pallete.preLoad,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 130,
                      width: width / 2,
                      decoration: const BoxDecoration(
                        color: Pallete.preLoad,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
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
                        width: width / 2,
                        height: 130,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              width: width / 2 - 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    widget.item.originalTitle,
                    maxLines: 3,
                    style: StyleFont.bold
                        .copyWith(color: Pallete.white, fontSize: 16),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        voteAverage.toStringAsFixed(1),
                        style: StyleFont.medium
                            .copyWith(color: Pallete.white, fontSize: 16),
                      ),
                      RatingStars(
                        value: 10,
                        starColor: Pallete.yellow,
                        starOffColor: Pallete.grayLight,
                        starSize: 20,
                        starCount: 1,
                        valueLabelVisibility: false,
                        starBuilder: (index, color) => Icon(
                          Icons.star_rounded,
                          color: color,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
