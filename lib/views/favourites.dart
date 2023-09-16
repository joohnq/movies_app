import 'package:flutter/material.dart';
import 'package:movies_app/controller/favourites_controller.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/widgets/custom_title.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({
    super.key,
  });

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  // final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, storedValue, child) {
        return Container(
          color: Pallete.grayDark,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
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
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  Text(storedValue.favoritesCount.toString()),
                  // GridView.builder(
                  //   controller: _scrollController,
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2,
                  //     mainAxisSpacing: 0,
                  //     crossAxisSpacing: 10,
                  //     childAspectRatio: width * 0.64 / width,
                  //   ),
                  //   shrinkWrap: true,
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   itemCount: storedValue.favoritesCount,
                  //   itemBuilder: (context, index) {
                  //     final MovieAndSerieDetailModel movie =
                  //         movieAndSeries[index];
                  //     return VerticalCard(
                  //       id: movie.id,
                  //       posterPath: movie.posterPath,
                  //       title: movie.originalTitle.isEmpty
                  //           ? movie.title.isEmpty
                  //               ? movie.name
                  //               : movie.title
                  //           : movie.originalName,
                  //       voteAverage: movie.voteAverage,
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
