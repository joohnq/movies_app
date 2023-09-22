import 'package:dartz/dartz.dart';
import 'package:movies_app/abstract/base_movie_and_serie_controller.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/movie_and_serie_model.dart';
import 'package:movies_app/models/movie_and_serie_response_model.dart';
import 'package:movies_app/repository/repositories.dart';

class MoviesPopularController extends BaseMovieAndSerieController {
  final _repository = MovieRepository();

  MovieAndSerieResponseModel? movieResponseModel;
  MovieError? itemError;

  @override
  List<MovieAndSerieModel> get item =>
      movieResponseModel?.results ?? <MovieAndSerieModel>[];

  @override
  int get itemCount => item.length;

  @override
  bool get hasItem => itemCount != 0;

  @override
  int get itemCurrentPage => movieResponseModel?.page ?? 1;

  @override
  int get itemTotalPages => movieResponseModel?.totalPages ?? 1;

  @override
  String get mediaType => "movie";

  @override
  Future<Either<MovieError, MovieAndSerieResponseModel>> fetchItems(
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

  @override
  Future<Either<MovieError, MovieAndSerieResponseModel>>
      fetchMoreMoviesByCategory(String category, {int page = 1}) async {
    itemError = null;
    final result = await _repository.fetchByCategory(page, category);
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

  @override
  Future<Either<MovieError, MovieAndSerieResponseModel>> fetchMoviesByCategory(
      String category,
      {int page = 1}) async {
    itemError = null;
    final result = await _repository.fetchByCategory(page, category);
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
