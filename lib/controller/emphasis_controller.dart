import 'package:dartz/dartz.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/repository/repositories.dart';

class EmphasisController {
  final _repository = MovieRepository();

  MovieModel? emphasis;
  MovieError? emphasisError;
  bool loading = true;

  bool get hasEmphasis => emphasis?.id == 0;
  String get backdropPath => emphasis?.backdropPath ?? "";
  int get id => emphasis?.id ?? 0;
  String get originalTitle => emphasis?.originalTitle ?? "";
  double get voteAverage => emphasis?.voteAverage ?? 0.0;

  Future<Either<MovieError, MovieModel>> fetchEmphasis({int page = 1}) async {
    emphasisError = null;
    final result = await _repository.fetchEmphasis(page);
    result.fold(
      (error) => emphasisError = error,
      (movie) => {
        if (emphasis != null)
          {
            emphasis?.backdropPath = movie.backdropPath,
            emphasis?.id = movie.id,
            emphasis?.originalTitle = movie.originalTitle,
            emphasis?.voteAverage = movie.voteAverage,
          }
        else
          {
            emphasis = movie,
          },
      },
    );
    return result;
  }
}
