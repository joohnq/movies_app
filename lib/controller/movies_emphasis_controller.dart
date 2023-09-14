import 'package:dartz/dartz.dart';
import 'package:movies_app/abstract/base_emphasis_controller.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/movie_and_serie_model.dart';
import 'package:movies_app/repository/repositories.dart';

class MovieEmphasisController extends BaseEmphasisController {
  final _repository = MovieRepository();

  MovieAndSerieModel? movieEmphasis;
  MovieError? itemError;

  @override
  String get backdropPath => movieEmphasis?.backdropPath ?? "";
  @override
  bool get hasEmphasis => movieEmphasis?.id == 0;
  @override
  int get id => movieEmphasis?.id ?? 0;
  @override
  String get mediaType => "movie";
  @override
  String get name => movieEmphasis?.name ?? "";
  @override
  String get originalName => movieEmphasis?.originalName ?? "";
  @override
  String get originalTitle => movieEmphasis?.originalTitle ?? "";
  @override
  String get overview => movieEmphasis?.overview ?? "";
  @override
  String get title => movieEmphasis?.title ?? "";
  @override
  double get voteAverage => movieEmphasis?.voteAverage ?? 0.0;

  @override
  Future<Either<MovieError, MovieAndSerieModel>> fetchEmphasis(
      {int page = 1}) async {
    itemError = null;
    final result = await _repository.fetchEmphasis(page, "movie");
    result.fold(
      (error) => itemError = error,
      (movie) => {
        if (movieEmphasis != null)
          {
            movieEmphasis?.backdropPath = movie.backdropPath,
            movieEmphasis?.id = movie.id,
            movieEmphasis?.name = movie.name,
            movieEmphasis?.originalName = movie.originalName,
            movieEmphasis?.originalTitle = movie.originalTitle,
            movieEmphasis?.overview = movie.overview,
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
