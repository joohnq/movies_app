import 'package:flutter/material.dart';
import 'package:movies_app/controller/movie_controller.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/widgets/slider_card.dart';

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
                  child: SliderCard(
                    item: value[index],
                  ),
                );
              },
            ),
    );
  }
}
