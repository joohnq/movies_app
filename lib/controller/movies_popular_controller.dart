import 'package:dartz/dartz.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/movie_and_serie_model.dart';
import 'package:movies_app/models/movie_and_serie_response_model.dart';
import 'package:movies_app/repository/repositories.dart';

class MoviesPopularController {
  final _repository = MovieRepository();

  MovieAndSerieResponseModel? movieResponseModel;
  MovieError? itemError;
  bool loading = true;

  List<MovieAndSerieModel> get item =>
      movieResponseModel?.results ?? <MovieAndSerieModel>[];

  int get itemCount => item.length;
  bool get hasItem => itemCount != 0;
  int get itemCurrentPage => movieResponseModel?.page ?? 1;
  int get itemTotalPages => movieResponseModel?.totalPages ?? 1;
  String get mediaType => "movie";

  Future<Either<MovieError, MovieAndSerieResponseModel>> fetchMovies(
      {int page = 1}) async {
    itemError = null;
    final result = await _repository.fetchPopular(page, "movie");
    result.fold(
      (error) => itemError = error,
      (movie) => {
        if (movieResponseModel != null)
          {
            movieResponseModel?.page = movie.page,
            movieResponseModel?.results.addAll(movie.results),
          }
        else
          {
            movieResponseModel = movie,
          },
      },
    );
    return result;
  }

  Future<Either<MovieError, MovieAndSerieResponseModel>> fetchMoviesByName(
      String title,
      {int page = 1}) async {
    itemError = null;
    final result = await _repository.fetchByName(page, title);
    result.fold(
      (error) => itemError = error,
      (movie) => {
        if (movieResponseModel != null)
          {
            movieResponseModel?.page = movie.page,
            movieResponseModel?.results = movie.results,
          }
        else
          {
            movieResponseModel = movie,
          },
      },
    );
    return result;
  }
}
