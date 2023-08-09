import 'package:flutter/material.dart';
import 'package:movies_app/models/movies_series.dart';
import 'package:movies_app/widgets/future_prompt.dart';
import 'package:movies_app/widgets/pre_load_carousel_slider.dart';
import 'package:movies_app/widgets/slider_card.dart';

class CarouselSlider extends StatefulWidget {
  final Future<List<Result>> item;

  const CarouselSlider({super.key, required this.item});

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: FutureBuilder<List<Result>>(
        future: widget.item,
        builder:
            (BuildContext context, AsyncSnapshot<List<Result>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const PreLoadCarouselSlider();
          } else if (snapshot.hasError) {
            return CustomFuturePrompt(
                text: "Ocorreu um erro: $snapshot.error");
          } else if (!snapshot.hasData) {
            return const CustomFuturePrompt(text: "Nenhum dado encontrado");
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              final Result value = snapshot.data![index];
              return SizedBox(
                width: 140,
                height: 200,
                child: SliderCard(
                  item: value,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
