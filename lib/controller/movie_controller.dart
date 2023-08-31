// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/movie_response.dart';
import 'package:movies_app/respositories.dart';

class MovieController {
  final _repository = MovieRepository();

  MovieResponseModel? movieResponseModel;
  MovieError? movieError;
  bool loading = true;

  List<MovieModel> get movies => movieResponseModel?.results ?? <MovieModel>[];

  int get moviesCount => movies.length;

  bool get hasMovies => moviesCount != 0;

  int get totalPages => movieResponseModel?.totalPages ?? 1;

  int get currentPage => movieResponseModel?.page ?? 1;

  Future<Either<MovieError, MovieResponseModel>> fetchPopularMovies(
      {int page = 1}) async {
    movieError = null;
    final result = await _repository.fetchPopularMovies(page);
    print(result);
    result.fold(
      (error) => movieError = error,
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
}
