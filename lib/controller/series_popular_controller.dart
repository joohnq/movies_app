import 'package:dartz/dartz.dart';
import 'package:movies_app/abstract/base_movie_and_serie_controller.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/movie_and_serie_model.dart';
import 'package:movies_app/models/movie_and_serie_response_model.dart';
import 'package:movies_app/repository/repositories.dart';

class SeriesPopularController extends BaseMovieAndSerieController {
  final _repository = MovieRepository();

  MovieAndSerieResponseModel? seriesResponseModel;
  MovieError? itemError;

  @override
  List<MovieAndSerieModel> get item =>
      seriesResponseModel?.results ?? <MovieAndSerieModel>[];

  @override
  int get itemCount => item.length;
  @override
  bool get hasItem => itemCount != 0;
  @override
  int get itemCurrentPage => seriesResponseModel?.page ?? 1;
  @override
  int get itemTotalPages => seriesResponseModel?.totalPages ?? 1;
  @override
  String get mediaType => "tv";

  @override
  Future<Either<MovieError, MovieAndSerieResponseModel>> fetchItems(
      {int page = 1}) async {
    itemError = null;
    final result = await _repository.fetchPopular(page, "tv");
    result.fold(
      (error) => itemError = error,
      (movie) => {
        if (seriesResponseModel != null)
          {
            seriesResponseModel?.page = movie.page,
            seriesResponseModel?.results.addAll(movie.results),
          }
        else
          {
            seriesResponseModel = movie,
          },
      },
    );
    return result;
  }
}
