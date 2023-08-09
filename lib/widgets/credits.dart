import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/credits.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/widgets/error_component.dart';
import 'package:movies_app/widgets/future_prompt.dart';
import 'package:movies_app/widgets/pre_load_credits.dart';
import 'package:movies_app/widgets/pre_load_emphasis_home.dart';

class Credits extends StatefulWidget {
  final Future<CreditsModel> credits;

  const Credits({super.key, required this.credits});

  @override
  State<Credits> createState() => _CreditsState();
}

class _CreditsState extends State<Credits> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CreditsModel>(
      future: widget.credits,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const PreLoadCredits();
        } else if (snapshot.hasError) {
          return const ErrorComponent();
        } else if (!snapshot.hasData) {
          return const CustomFuturePrompt(text: "Nenhum dado encontrado");
        }
        final credits = snapshot.data;

        return SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: credits!.cast.length <= 12 ? credits.cast.length : 12,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          "https://image.tmdb.org/t/p/w500${credits.cast[index].profilePath}",
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
                          credits.cast[index].originalName,
                          style: StyleFont.medium
                              .copyWith(color: Pallete.white, fontSize: 14),
                        ),
                        AutoSizeText(
                          credits.cast[index].character ?? "",
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
      },
    );
  }
}
