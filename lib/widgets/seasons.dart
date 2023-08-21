import 'package:flutter/material.dart';
import 'package:movies_app/formatting.dart';
import 'package:movies_app/models/movies_series.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';

class CustomSeasons extends StatelessWidget {
  final Result item;
  final double totalWidth;
  const CustomSeasons({Key? key, required this.item, required this.totalWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Temporadas :",
          style: StyleFont.bold.copyWith(color: Pallete.white, fontSize: 24),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: totalWidth,
          height: 300.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: item.seasons!.length,
            itemBuilder: (BuildContext context, int index) {
              final season = item.seasons![index];

              String date = Formating.formatDate(
                  season.airDate.toString().substring(0, 10));
              return Container(
                height: 300.0,
                margin: const EdgeInsets.only(right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 130,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          "https://image.tmdb.org/t/p/w500${season.posterPath}",
                          fit: BoxFit.cover,
                          height: 150,
                          width: 100,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      season.name,
                      style: StyleFont.medium
                          .copyWith(color: Pallete.white, fontSize: 14),
                    ),
                    Text(
                      "Episódios: ${season.episodeCount}",
                      style: StyleFont.medium
                          .copyWith(color: Pallete.grayLight, fontSize: 13),
                    ),
                    Text(
                      "Publicado em:",
                      style: StyleFont.medium
                          .copyWith(color: Pallete.grayLight, fontSize: 13),
                    ),
                    Text(
                      date,
                      style: StyleFont.medium
                          .copyWith(color: Pallete.grayLight, fontSize: 13),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
