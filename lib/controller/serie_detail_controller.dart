import 'package:dartz/dartz.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/backdrop_model.dart';
import 'package:movies_app/models/cast_model.dart';
import 'package:movies_app/models/genre_model.dart';
import 'package:movies_app/models/movie_and_serie_detail_model.dart';
import 'package:movies_app/models/movie_credits_model.dart';
import 'package:movies_app/models/movie_images_model.dart';
import 'package:movies_app/repository/repositories.dart';

class SerieDetailController {
  final _repository = MovieRepository();

  MovieAndSerieDetailModel? serieDetail;
  MovieError? serieDetailError;
  bool serieDetailLoading = true;

  MovieImagesModel? serieImages;
  MovieError? serieImagesError;
  bool serieImagesLoading = true;

  MovieCreditsModel? serieCredits;
  MovieError? serieCreditsError;
  bool serieCreditsLoading = true;

  int get budget => serieDetail?.budget ?? 0;
  List<Genre> get genres => serieDetail?.genres ?? <Genre>[];
  String get originalLanguage => serieDetail?.originalLanguage ?? "";
  String get originalTitle => serieDetail?.originalTitle ?? "";
  String get overview => serieDetail?.overview ?? "";
  String get posterPath => serieDetail?.posterPath ?? "";
  String get releaseDate => serieDetail?.releaseDate ?? "";
  int get runtime => serieDetail?.runtime ?? 0;
  String get title => serieDetail?.title ?? "";
  String get voteAverage => serieDetail?.voteAverage.toStringAsFixed(1) ?? "";

  List<Backdrop> get images =>
      serieImages?.backdrops.take(10).toList() ?? <Backdrop>[];
  int get imagesCount => images.take(10).length;

  List<Cast> get cast => serieCredits?.cast ?? <Cast>[];
  List<Cast> get crew => serieCredits?.crew ?? <Cast>[];

  Future<Either<MovieError, MovieAndSerieDetailModel>> fetchMovieById(
      int id) async {
    serieDetailError = null;
    final result = await _repository.fetchSerieById(id);
    result.fold(
      (error) => serieDetailError = error,
      (detail) => {
        if (serieDetail != null)
          {
            serieDetail?.budget = detail.budget,
            serieDetail?.genres = detail.genres,
            serieDetail?.originalLanguage = detail.originalLanguage,
            serieDetail?.originalTitle = detail.originalTitle,
            serieDetail?.overview = detail.overview,
            serieDetail?.posterPath = detail.posterPath,
            serieDetail?.releaseDate = detail.releaseDate,
            serieDetail?.title = detail.title,
            serieDetail?.voteAverage = detail.voteAverage,
          }
        else
          {
            serieDetail = detail,
          },
      },
    );

    return result;
  }

  Future<Either<MovieError, MovieImagesModel>> fetchMovieImages(int id) async {
    serieImagesError = null;
    final result = await _repository.fetchSerieImages(id);
    result.fold(
      (error) => serieImagesError = error,
      (images) => {
        serieImages = images,
      },
    );

    return result;
  }

  Future<Either<MovieError, MovieCreditsModel>> fetchMovieCredits(
      int id) async {
    serieCreditsError = null;
    final result = await _repository.fetchSerieCredits(id);
    result.fold(
      (error) => serieCreditsError = error,
      (credits) => {
        if (serieCredits != null)
          {
            serieCredits?.cast = credits.cast,
            serieCredits?.crew = credits.crew,
          }
        else
          {
            serieCredits = credits,
          },
      },
    );

    return result;
  }
}
