// ignore_for_file: avoid_print

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:movies_app/models/getx_atributes.dart';
import 'package:movies_app/models/movies_series.dart';
import 'package:movies_app/service/favourites_service.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';

class HorizontalCard extends StatefulWidget {
  final Result item;

  const HorizontalCard({super.key, required this.item});

  @override
  State<HorizontalCard> createState() => _HorizontalCardState();
}

class _HorizontalCardState extends State<HorizontalCard> {
  bool itsFavourite = false;

  @override
  void initState() {
    super.initState();
    getFavouriteStatus();
  }

  getFavouriteStatus() async {
    bool isFavourite =
        await FavouritesService.getIfIsAlreadyFavourite("${widget.item.id}");
    setState(() {
      itsFavourite = isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 40;
    final voteAverage = widget.item.voteAverage / 2;

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          'moviedetail',
          arguments: GetxAtributes(
            widget.item.id,
            widget.item.originalTitle == ""
                ? widget.item.name ?? ""
                : widget.item.originalTitle ?? "",
          ),
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
                      print(imageProvider);
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
                Positioned(
                  top: 0,
                  left: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        itsFavourite = !itsFavourite;
                      });
                      FavouritesService.changeFavouriteStatus();
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        color: Pallete.yellow,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                        ),
                      ),
                      child: itsFavourite
                          ? const Icon(
                              Icons.bookmark,
                              color: Pallete.grayDark,
                              size: 30,
                            )
                          : const Icon(
                              Icons.bookmark_border_outlined,
                              color: Pallete.grayDark,
                              size: 30,
                            ),
                    ),
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
                    widget.item.name == ""
                        ? widget.item.title
                        : widget.item.name ?? '',
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
