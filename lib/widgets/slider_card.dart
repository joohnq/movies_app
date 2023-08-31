import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';

class SliderCard extends StatefulWidget {
  final MovieModel item;

  const SliderCard({
    super.key,
    required this.item,
  });

  @override
  State<SliderCard> createState() => _SliderCardState();
}

class _SliderCardState extends State<SliderCard> {
  @override
  void initState() {
    super.initState();
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
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
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
    );
  }
}
