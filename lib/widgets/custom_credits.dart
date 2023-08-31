// ignore_for_file: avoid_print

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/cast.dart';
import 'package:movies_app/models/credits.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';

class CustomCredits extends StatefulWidget {
  final Credits credits;

  const CustomCredits({super.key, required this.credits});

  @override
  State<CustomCredits> createState() => _CustomCreditsState();
}

class _CustomCreditsState extends State<CustomCredits> {
  @override
  Widget build(BuildContext context) {
    List<Cast> creditCast = widget.credits.cast;
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: creditCast.length <= 12 ? creditCast.length : 12,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl:
                      "https://image.tmdb.org/t/p/w500${creditCast[index].profilePath}",
                  placeholder: (context, url) => Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Pallete.preLoad,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Pallete.white,
                  ),
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      creditCast[index].originalName,
                      style: StyleFont.medium
                          .copyWith(color: Pallete.white, fontSize: 14),
                    ),
                    AutoSizeText(
                      creditCast[index].character ?? "",
                      style: StyleFont.medium
                          .copyWith(color: Pallete.grayLight, fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
