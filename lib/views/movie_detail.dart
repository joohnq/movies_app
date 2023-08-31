import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controller/movie_detail_controller.dart';
// import 'package:movies_app/service/api_service.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/widgets/movie_detail_content.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({Key? key}) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  final int id = Get.arguments.id;
  final _controller = MovieDetailController();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    setState(() {
      _controller.loading = true;
    });

    await _controller.fetchMovieById(id);

    setState(() {
      _controller.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.grayDark,
      body: MovieDetailContent(
        item: _controller.movieDetail,
      ),
    );
  }
}
