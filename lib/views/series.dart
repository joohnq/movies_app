import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/abstract/base_emphasis_controller.dart';
import 'package:movies_app/controller/series_emphasis_controller.dart';
import 'package:movies_app/controller/series_popular_controller.dart';
import 'package:movies_app/controller/series_trending_controller.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/widgets/carousel_slider.dart';
import 'package:movies_app/widgets/custom_title.dart';
import 'package:movies_app/widgets/emphasis_home.dart';
import 'package:movies_app/widgets/pre_load_carousel_slider.dart';
import 'package:movies_app/widgets/pre_load_emphasis_home.dart';

class Series extends StatefulWidget {
  const Series({
    super.key,
  });

  @override
  State<Series> createState() => _SeriesState();
}

class _SeriesState extends State<Series> {
  final _controllerPopular = SeriesPopularController();
  final _controllerTrending = SeriesTrendingController();
  final BaseEmphasisController _controllerEmphasis = SeriesEmphasisController();
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    setState(() {
      _controllerPopular.loading = true;
      _controllerTrending.loading = true;
      _controllerEmphasis.loading = true;
    });

    await _controllerPopular.fetchSeries(page: lastPage);
    await _controllerTrending.fetchTrending(page: lastPage);
    await _controllerEmphasis.fetchEmphasis(page: lastPage);

    setState(() {
      _controllerPopular.loading = false;
      _controllerTrending.loading = false;
      _controllerEmphasis.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallete.grayDark,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _controllerEmphasis.loading
                ? const PreLoadEmphasisHome()
                : EmphasisHome(
                    id: _controllerEmphasis.id,
                    backdropPath: _controllerEmphasis.backdropPath,
                    title: _controllerEmphasis.title.isEmpty
                        ? _controllerEmphasis.name.isEmpty
                            ? _controllerEmphasis.originalName.isEmpty
                                ? _controllerEmphasis.originalTitle
                                : _controllerEmphasis.originalName
                            : _controllerEmphasis.name
                        : _controllerEmphasis.title,
                    voteAverage: _controllerEmphasis.voteAverage,
                  ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTitle(text: "Popular"),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        '/seemore',
                      );
                    },
                    child: Text(
                      "SEE MORE",
                      style: StyleFont.regular.copyWith(color: Pallete.yellow),
                    ),
                  )
                ],
              ),
            ),
            _controllerPopular.loading
                ? const PreLoadCarouselSlider()
                : CarouselSlider<SeriesPopularController>(
                    item: _controllerPopular,
                    mediaType: "serie",
                  ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomTitle(text: "Trending"),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        '/seemore',
                      );
                    },
                    child: Text(
                      "SEE MORE",
                      style: StyleFont.regular.copyWith(color: Pallete.yellow),
                    ),
                  )
                ],
              ),
            ),
            _controllerTrending.loading
                ? const PreLoadCarouselSlider()
                : CarouselSlider<SeriesTrendingController>(
                    item: _controllerTrending,
                    mediaType: "serie",
                  ),
          ],
        ),
      ),
    );
  }
}
