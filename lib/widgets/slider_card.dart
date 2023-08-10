import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/models/getx_atributes.dart';
import 'package:movies_app/models/movies_series.dart';
import 'package:movies_app/service/favourites_service.dart';
import 'package:movies_app/style/colors.dart';

class SliderCard extends StatefulWidget {
  final Result item;

  const SliderCard({
    super.key,
    required this.item,
  });

  @override
  State<SliderCard> createState() => _SliderCardState();
}

class _SliderCardState extends State<SliderCard> {
  late bool itsFavourite = false;

  @override
  void initState() {
    super.initState();
    getFavouriteStatus();
  }

  getFavouriteStatus() async {
    bool isFavourite = await FavouritesService.getIfIsAlreadyFavourite(
        widget.item.id.toString());
    setState(() {
      itsFavourite = isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 600,
      padding: const EdgeInsets.all(4),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                "https://image.tmdb.org/t/p/w500${widget.item.posterPath}",
            placeholder: (context, url) => Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Pallete.preLoad,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              height: double.infinity,
              width: double.infinity,
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
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    "/moviedetail",
                    arguments: GetxAtributes(
                      widget.item.id,
                      widget.item.originalTitle == ""
                          ? widget.item.name ?? ""
                          : widget.item.originalTitle ?? "",
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 0,
            left: 0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  itsFavourite = !itsFavourite;
                });
                FavouritesService.changeFavouriteStatus(
                    json.encode([
                      widget.item.id.toString(),
                      widget.item.name == ""
                          ? widget.item.title
                          : widget.item.name ?? '',
                    ]),
                    itsFavourite);
              },
              child: Container(
                height: 35,
                width: 35,
                decoration: const BoxDecoration(
                  color: Pallete.yellow,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
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
    );
  }
}
