import 'package:dartz/dartz.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/movie_and_serie_model.dart';
import 'package:movies_app/repository/repositories.dart';

class SeriesEmphasisController {
  final _repository = MovieRepository();

  MovieAndSerieModel? seriesEmphasis;
  MovieError? seriesEmphasisError;
  bool seriesEmphasisLoading = true;

  bool get hasEmphasis => seriesEmphasis?.id == 0;
  String get backdropPath => seriesEmphasis?.backdropPath ?? "";
  int get id => seriesEmphasis?.id ?? 0;
  String get originalTitle => seriesEmphasis?.originalName ?? "";
  String get title => seriesEmphasis?.name ?? "";

  double get voteAverage => seriesEmphasis?.voteAverage ?? 0.0;

  Future<Either<MovieError, MovieAndSerieModel>> fetchSeriesEmphasis(
      {int page = 1}) async {
    seriesEmphasisError = null;
    final result = await _repository.fetchSeriesEmphasis(page);
    result.fold(
      (error) => seriesEmphasisError = error,
      (serie) => {
        if (seriesEmphasis != null)
          {
            seriesEmphasis?.backdropPath = serie.backdropPath,
            seriesEmphasis?.id = serie.id,
            seriesEmphasis?.originalName = serie.originalName,
            seriesEmphasis?.name = serie.name,
            seriesEmphasis?.voteAverage = serie.voteAverage,
          }
        else
          {
            seriesEmphasis = serie,
          },
      },
    );
    return result;
  }
}
