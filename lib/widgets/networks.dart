import 'package:flutter/material.dart';
import 'package:movies_app/models/movies_series.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';

class CustomNetworks extends StatelessWidget {
  final Result item;
  final double totalWidth;
  const CustomNetworks({Key? key, required this.item, required this.totalWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Disponivel em:",
          style: StyleFont.bold.copyWith(color: Pallete.white, fontSize: 24),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: totalWidth,
          height: 40.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: item.networks!.length,
            itemBuilder: (BuildContext context, int index) {
              final network = item.networks![index];
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Pallete.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500${network.logoPath}",
                      height: 30,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
