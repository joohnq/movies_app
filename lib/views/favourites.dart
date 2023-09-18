// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/tabler.dart';
import 'package:movies_app/controller/favourites_controller.dart';
import 'package:movies_app/core/api.dart';
import 'package:movies_app/models/favorites_model.dart';
import 'package:movies_app/models/movie_and_serie_detail_model.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/widgets/custom_title.dart';
import 'package:movies_app/widgets/vertical_card.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({
    super.key,
  });

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  Future<List<MovieAndSerieDetailModel>> fetchFavoritesDetails(
      List<String> favorites) async {
    final Dio dio = Dio(kDioOption);
    List<MovieAndSerieDetailModel> details = [];

    for (String favorite in favorites) {
      Map<dynamic, dynamic> jsonData = json.decode(favorite);

      FavouriteModel item = FavouriteModel(
        id: jsonData['id'],
        mediaType: jsonData['mediaType'],
      );

      try {
        final response =
            await dio.get('/${item.mediaType}/${item.id}?language=en-US');
        final model = MovieAndSerieDetailModel.fromJson(response.data);
        model.mediaType = item.mediaType;
        details.add(model);
      } catch (error) {
        print('Erro ao buscar detalhes: $error');
      }
    }

    return details;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Consumer<FavoritesProvider>(
      builder: (context, storedValue, child) {
        return Container(
          color: Pallete.grayDark,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
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
                  ),
                  FutureBuilder(
                    future: fetchFavoritesDetails(storedValue.favorites),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text(
                            'Erro ao carregar detalhes: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Expanded(
                            child: Column(
                              children: [
                                Iconify(
                                  Tabler.error_404,
                                  size: width * 0.6,
                                  color: Pallete.grayLight,
                                ),
                                AutoSizeText(
                                  'Você não tem itens salvos nos favoritos!',
                                  style: StyleFont.bold.copyWith(
                                      fontSize: 28, color: Pallete.grayLight),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        List<MovieAndSerieDetailModel> items =
                            snapshot.data ?? <MovieAndSerieDetailModel>[];
                        return GridView.builder(
                          controller: _scrollController,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 10,
                            childAspectRatio: width * 0.64 / width,
                          ),
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            // print(storedValue.favorites);
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
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
