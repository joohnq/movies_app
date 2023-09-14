import 'package:dartz/dartz.dart';
import 'package:movies_app/abstract/base_emphasis_controller.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/movie_and_serie_model.dart';
import 'package:movies_app/repository/repositories.dart';

class SeriesEmphasisController extends BaseEmphasisController {
  final _repository = MovieRepository();

  MovieAndSerieModel? seriesEmphasis;
  MovieError? itemError;

  @override
  bool get hasEmphasis => seriesEmphasis?.id == 0;
  @override
  String get backdropPath => seriesEmphasis?.backdropPath ?? "";
  @override
  int get id => seriesEmphasis?.id ?? 0;
  @override
  String get originalTitle => seriesEmphasis?.originalTitle ?? "";
  String get originalName => seriesEmphasis?.originalName ?? "";
  @override
  String get title => seriesEmphasis?.title ?? "";
  String get name => seriesEmphasis?.name ?? "";
  @override
  String get mediaType => "serie";

  @override
  double get voteAverage => seriesEmphasis?.voteAverage ?? 0.0;

  @override
  Future<Either<MovieError, MovieAndSerieModel>> fetchEmphasis(
      {int page = 1}) async {
    itemError = null;
    final result = await _repository.fetchEmphasis(page, "tv");
    result.fold(
      (error) => itemError = error,
      (serie) => {
        if (seriesEmphasis != null)
          {
            seriesEmphasis?.backdropPath = serie.backdropPath,
            seriesEmphasis?.id = serie.id,
            seriesEmphasis?.originalName = serie.originalName,
            seriesEmphasis?.originalTitle = serie.originalTitle,
            seriesEmphasis?.name = serie.name,
            seriesEmphasis?.title = serie.title,
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
