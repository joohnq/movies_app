import 'package:dartz/dartz.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/movie_and_serie_model.dart';
import 'package:movies_app/repository/repositories.dart';

class MovieEmphasisController {
  final _repository = MovieRepository();

  MovieAndSerieModel? movieEmphasis;
  MovieError? movieEmphasisError;
  bool moviesEmphasisLoading = true;

  bool get hasEmphasis => movieEmphasis?.id == 0;
  String get backdropPath => movieEmphasis?.backdropPath ?? "";
  int get id => movieEmphasis?.id ?? 0;
  String get originalTitle => movieEmphasis?.originalTitle ?? "";
  String get title => movieEmphasis?.title ?? "";
  double get voteAverage => movieEmphasis?.voteAverage ?? 0.0;

  Future<Either<MovieError, MovieAndSerieModel>> fetchEmphasis(
      {int page = 1}) async {
    movieEmphasisError = null;
    final result = await _repository.fetchEmphasis(page);
    result.fold(
      (error) => movieEmphasisError = error,
      (movie) => {
        if (movieEmphasis != null)
          {
            movieEmphasis?.backdropPath = movie.backdropPath,
            movieEmphasis?.id = movie.id,
            movieEmphasis?.originalTitle = movie.originalTitle,
            movieEmphasis?.title = movie.title,
            movieEmphasis?.voteAverage = movie.voteAverage,
          }
        else
          {
            movieEmphasis = movie,
          },
      },
    );
    return result;
  }
}
