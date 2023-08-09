import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/models/getx_atributes.dart';
import 'package:movies_app/models/movies_series.dart';
import 'package:movies_app/service/favourites_service.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';

class VerticalCard<T> extends StatefulWidget {
  final Result item;

  const VerticalCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<VerticalCard> createState() => _VerticalCardState();
}

class _VerticalCardState extends State<VerticalCard> {
  bool itsFavourite = false;

  @override
  void initState() {
    super.initState();
    initializeFavourite();
  }

  Future initializeFavourite() async {
    final isFavourite =
        await FavouritesService.getIfIsAlreadyFavourite("${widget.item.id}");
    setState(() {
      itsFavourite = isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: height * 0.4,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://image.tmdb.org/t/p/w500${widget.item.posterPath}",
                      placeholder: (context, url) => Container(
                        height: height * 0.4,
                        width: height * 0.4,
                        decoration: BoxDecoration(
                          color: Pallete.preLoad,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: height * 0.4,
                        width: width,
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
                          width: width,
                          height: height * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  height: height * 0.4,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Pallete.transparent20,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   itsFavourite = !itsFavourite;
                      // });
                      // FavouritesService.changeFavouriteStatus(
                      //     widget.item.id, itsFavourite);
                      // if (isFavorite) {
                      //   favouritesProvider.handleFavourite(
                      //       widget.item.id, isFavorite);
                      // } else {
                      //   favouritesProvider.handleFavourite(
                      //       widget.item.id, isFavorite);
                      // }
                    },
                    child: itsFavourite
                        ? const Icon(
                            Icons.bookmark,
                            color: Pallete.white,
                            size: 30,
                          )
                        : const Icon(
                            Icons.bookmark_border_outlined,
                            color: Pallete.white,
                            size: 30,
                          ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 10,
                  child: Container(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
