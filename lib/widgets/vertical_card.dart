import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/favourites_controller.dart';
import 'package:movies_app/models/getx_atributes_model.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:provider/provider.dart';

class VerticalCard extends StatefulWidget {
  final int id;
  final String mediaType;
  final String posterPath;
  final String title;
  final double voteAverage;

  const VerticalCard({
    Key? key,
    required this.id,
    required this.mediaType,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
  }) : super(key: key);

  @override
  State<VerticalCard> createState() => _VerticalCardState();
}

class _VerticalCardState extends State<VerticalCard> {
  late bool itsFavorite;

  @override
  void initState() {
    super.initState();
    // ignore: avoid_print
    print(widget.mediaType);
    itsFavorite = context.read<FavoritesProvider>().itsFavorite(
          '{"id": "${widget.id}", "mediaType": "${widget.mediaType}"}',
        );
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
              id: widget.id, mediaType: widget.mediaType, title: widget.title),
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
                  height: width * 0.64,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://image.tmdb.org/t/p/w500${widget.posterPath}",
                      placeholder: (context, url) => Container(
                        height: width * 0.64,
                        width: width,
                        decoration: BoxDecoration(
                          color: Pallete.preLoad,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: width * 0.64,
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
                          height: width * 0.64,
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
                  height: width * 0.64,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Pallete.transparent20,
                  ),
                ),
                Positioned(
                  top: 10,
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
                      widget.voteAverage.toStringAsFixed(1),
                      style: StyleFont.bold
                          .copyWith(color: Pallete.grayDark, fontSize: 14),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 40,
                  child: Consumer<FavoritesProvider>(
                    builder: (context, storedValue, child) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            itsFavorite = !itsFavorite;
                          });

                          itsFavorite
                              ? storedValue.addToFavorites(
                                  '{"id": "${widget.id}", "mediaType": "${widget.mediaType}"}',
                                )
                              : storedValue.removeFromFavorites(
                                  '{"id": "${widget.id}", "mediaType": "${widget.mediaType}"}',
                                );
                        },
                        child: itsFavorite
                            ? const Icon(
                                Icons.bookmark,
                                size: 30,
                                color: Pallete.white,
                              )
                            : const Icon(
                                Icons.bookmark_border,
                                size: 30,
                                color: Pallete.white,
                              ),
                      );
                    },
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
