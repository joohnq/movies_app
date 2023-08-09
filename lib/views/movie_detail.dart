import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/models/movie_images.dart';
import 'package:movies_app/models/movies_series.dart';
import 'package:movies_app/service/api_service.dart';
import 'package:movies_app/service/favourites_service.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/widgets/error_component.dart';
import 'package:movies_app/widgets/future_prompt.dart';
import 'package:movies_app/widgets/movie_detail_content.dart';
import 'package:movies_app/widgets/pre_load_movie_detail.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({Key? key}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final int id = Get.arguments.id;
  final String originalTitle = Get.arguments.originalTitle;
  late bool itsFavourite = false;
  late Future<Result> itemData;
  late Future<List<Backdrop>> images;

  @override
  void initState() {
    super.initState();
    itemData = MovieService.getWithId(id, originalTitle).then((value) => value);
    images = MovieService.getImages(id).then((value) => value);
    initializeFavourite();
  }

  Future initializeFavourite() async {
    final isFavourite = await FavouritesService.getIfIsAlreadyFavourite(id);
    setState(() {
      itsFavourite = isFavourite;
    });
  }

  setFavouriteState(bool value) {
    setState(() {
      itsFavourite = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.grayDark,
      body: FutureBuilder<Result>(
        future: itemData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const PreLoadMovieDetail();
          } else if (snapshot.hasError) {
            return const Center(child: ErrorComponent());
          } else if (!snapshot.hasData) {
            return const CustomFuturePrompt(text: "Nenhum dado encontrado");
          }

          final item = snapshot.data;

          return MovieDetailContent(
            item: item,
            setFavouriteState: setFavouriteState,
            itsFavourite: itsFavourite,
            images: images,
          );
        },
      ),
    );
  }
}
