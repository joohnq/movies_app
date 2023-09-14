import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/season_model.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/tools/formatting.dart';

class Seasons extends StatelessWidget {
  final List<Season> seasons;
  final String posterPath;
  final double width;

  const Seasons({
    Key? key,
    required this.seasons,
    required this.posterPath,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Text(
            "Temporadas :",
            style: StyleFont.bold.copyWith(color: Pallete.white, fontSize: 24),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: width,
          height: 300.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: seasons.length,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            itemBuilder: (BuildContext context, int index) {
              final season = seasons[index];

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
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://image.tmdb.org/t/p/w500${season.posterPath}",
                          placeholder: (context, url) => Container(
                            width: 130,
                            height: 200,
                            decoration:
                                const BoxDecoration(color: Pallete.preLoad),
                          ),
                          errorWidget: (context, url, error) =>
                              CachedNetworkImage(
                            imageUrl:
                                "https://image.tmdb.org/t/p/w500$posterPath",
                            placeholder: (context, url) => Container(
                              width: 130,
                              height: 200,
                              decoration:
                                  const BoxDecoration(color: Pallete.preLoad),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              color: Pallete.white,
                            ),
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                width: 130,
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              width: 130,
                              height: 200,
                              decoration: BoxDecoration(
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
