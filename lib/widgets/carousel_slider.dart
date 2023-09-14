import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/models/getx_atributes_model.dart';
import 'package:movies_app/models/movie_and_serie_model.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';

class CarouselSlider<T> extends StatefulWidget {
  final T item;
  final String mediaType;

  const CarouselSlider({
    super.key,
    required this.item,
    required this.mediaType,
  });

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.item.itemCount,
        itemBuilder: (BuildContext context, int index) {
          final MovieAndSerieModel value = widget.item.item[index];
          final String title = value.title.isEmpty
              ? value.name.isEmpty
                  ? value.originalName.isEmpty
                      ? value.originalTitle
                      : value.originalName
                  : value.name
              : value.title;

          return SizedBox(
            width: 140,
            height: 200,
            child: _buildSliderCard(
              widget.mediaType,
              value.posterPath,
              value.id,
              value.voteAverage,
              title,
            ),
          );
        },
      ),
    );
  }

  _buildSliderCard(
    String mediaType,
    String posterPath,
    int id,
    double voteAverage,
    String title,
  ) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          "/moviedetail",
          arguments: GetxAtributes(
            id: id,
            mediaType: mediaType,
            title: title,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: "https://image.tmdb.org/t/p/w500$posterPath",
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
                return Container(
                  width: double.infinity,
                  height: double.infinity,
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
                  voteAverage.toStringAsFixed(1),
                  style: StyleFont.bold
                      .copyWith(color: Pallete.grayDark, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
