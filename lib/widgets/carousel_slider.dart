import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/movie_controller.dart';
import 'package:movies_app/models/getx_atributes_model.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';

class CarouselSlider extends StatefulWidget {
  final MovieController item;

  const CarouselSlider({super.key, required this.item});

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: widget.item.moviesCount == 0
          ? const Text("Vazio")
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.item.moviesCount,
              itemBuilder: (BuildContext context, int index) {
                final List<MovieModel> value = widget.item.movies;
                return SizedBox(
                  width: 140,
                  height: 200,
                  child: _buildSliderCard(value[index]),
                );
              },
            ),
    );
  }

  _buildSliderCard(MovieModel item) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: "https://image.tmdb.org/t/p/w500${item.posterPath}",
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
                    arguments: GetxAtributes(id: item.id),
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
                item.voteAverage.toStringAsFixed(1),
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
