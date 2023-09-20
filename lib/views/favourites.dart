import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/tabler.dart';
import 'package:movies_app/controller/favourites_controller.dart';
import 'package:movies_app/models/movie_and_serie_detail_model.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/widgets/custom_title.dart';
import 'package:movies_app/widgets/vertical_card.dart';
import 'package:provider/provider.dart';

class Favourites extends StatelessWidget {
  const Favourites({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Consumer<FavoritesProvider>(
      builder: (context, storedValue, child) {
        return Container(
          color: Pallete.grayDark,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomTitle(text: "Favourites"),
                        Consumer<FavoritesProvider>(
                          builder: (context, storedValue, child) {
                            return GestureDetector(
                              onTap: () async {
                                storedValue.cleanFavorites();
                              },
                              child: const Icon(
                                Icons.delete,
                                size: 28,
                                color: Pallete.white,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                    storedValue.favoritesFetched.isNotEmpty
                        ? GridView.builder(
                            controller: scrollController,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 10,
                              childAspectRatio: width * 0.64 / width,
                            ),
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            itemCount: storedValue.favoritesFetched.length,
                            itemBuilder: (context, index) {
                              List<MovieAndSerieDetailModel> items =
                                  storedValue.favoritesFetched;
                              return VerticalCard(
                                id: items[index].id,
                                mediaType: items[index].mediaType,
                                posterPath: items[index].posterPath,
                                title: items[index].originalTitle.isEmpty
                                    ? items[index].title.isEmpty
                                        ? items[index].name
                                        : items[index].title
                                    : items[index].originalTitle,
                                voteAverage: items[index].voteAverage,
                              );
                            },
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            height: height - 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Iconify(
                                  Tabler.error_404,
                                  size: width * 0.5,
                                  color: Pallete.grayLight,
                                ),
                                AutoSizeText(
                                  'Você não tem itens salvos nos favoritos!',
                                  style: StyleFont.bold.copyWith(
                                      fontSize: 24, color: Pallete.grayLight),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                )
                              ],
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
