import 'package:dartz/dartz.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/movie_and_serie_model.dart';
import 'package:movies_app/models/movie_and_serie_response_model.dart';
import 'package:movies_app/repository/repositories.dart';

class SeriesTrendingController {
  final _repository = MovieRepository();

  MovieAndSerieResponseModel? seriesResponseModel;
  MovieError? seriesError;
  bool seriesLoading = true;

  List<MovieAndSerieModel> get item =>
      seriesResponseModel?.results ?? <MovieAndSerieModel>[];
  int get itemCount => item.length;
  bool get hasItem => itemCount != 0;
  int get itemTotalPages => seriesResponseModel?.totalPages ?? 1;
  int get itemCurrentPage => seriesResponseModel?.page ?? 1;

  Future<Either<MovieError, MovieAndSerieResponseModel>> fetchTrendingSeries(
      {int page = 1}) async {
    seriesError = null;
    final result = await _repository.fetchTrendingSeries(page);
    result.fold(
      (error) => seriesError = error,
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
