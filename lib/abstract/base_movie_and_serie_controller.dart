import 'package:dartz/dartz.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/movie_and_serie_model.dart';
import 'package:movies_app/models/movie_and_serie_response_model.dart';

abstract class BaseMovieAndSerieController {
  bool get hasItem;
  List<MovieAndSerieModel> get item;
  int get itemCount;
  int get itemCurrentPage;
  int get itemTotalPages;
  bool loading = false;
  String get mediaType;

  Future<Either<MovieError, MovieAndSerieResponseModel>> fetchItems(
      {int page = 1});

  Future<Either<MovieError, MovieAndSerieResponseModel>> fetchMoviesByCategory(
      String category,
      {int page = 1});

  Future<Either<MovieError, MovieAndSerieResponseModel>>
      fetchMoreMoviesByCategory(String category, {int page = 1});
}
