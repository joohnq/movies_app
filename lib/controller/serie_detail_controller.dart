import 'package:dartz/dartz.dart';
import 'package:movies_app/abstract/base_detail_controller.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/backdrop_model.dart';
import 'package:movies_app/models/cast_model.dart';
import 'package:movies_app/models/genre_model.dart';
import 'package:movies_app/models/movie_and_serie_detail_model.dart';
import 'package:movies_app/models/movie_credits_model.dart';
import 'package:movies_app/models/movie_images_model.dart';
import 'package:movies_app/models/network_model.dart';
import 'package:movies_app/models/season_model.dart';
import 'package:movies_app/repository/repositories.dart';

class SerieDetailController extends BaseDetailController {
  final _repository = MovieRepository();

  MovieAndSerieDetailModel? serieDetail;
  MovieError? detailError;

  MovieImagesModel? serieImages;
  MovieError? imagesError;

  MovieCreditsModel? serieCredits;
  MovieError? creditsError;

  @override
  int get budget => serieDetail?.budget ?? 0;
  @override
  List<Genre> get genres => serieDetail?.genres ?? <Genre>[];
  @override
  String get mediaType => "serie";
  @override
  String get name => serieDetail?.name ?? "";
  @override
  List<Network> get networks => serieDetail?.networks ?? <Network>[];
  @override
  String get originalLanguage => serieDetail?.originalLanguage ?? "";
  @override
  String get originalName => serieDetail?.originalName ?? "";
  @override
  String get originalTitle => serieDetail?.originalTitle ?? "";
  @override
  String get overview => serieDetail?.overview ?? "";
  @override
  String get posterPath => serieDetail?.posterPath ?? "";
  @override
  String get releaseDate => serieDetail?.releaseDate ?? "";
  @override
  int get runtime => serieDetail?.runtime ?? 0;
  @override
  List<Season> get seasons => serieDetail?.seasons ?? <Season>[];
  @override
  String get title => serieDetail?.title ?? "";
  @override
  String get voteAverage => serieDetail?.voteAverage.toStringAsFixed(1) ?? "";

  @override
  List<Backdrop> get images =>
      serieImages?.backdrops.take(10).toList() ?? <Backdrop>[];
  @override
  int get imagesCount => images.take(10).length;

  @override
  List<Cast> get cast => serieCredits?.cast ?? <Cast>[];
  @override
  List<Cast> get crew => serieCredits?.crew ?? <Cast>[];

  @override
  Future<Either<MovieError, MovieAndSerieDetailModel>> fetchById(
      int id, String title) async {
    detailError = null;
    final result = await _repository.fetchById(id, "tv", title);
    result.fold(
      (error) => detailError = error,
      (detail) => {
        if (serieDetail != null)
          {
            serieDetail?.budget = detail.budget,
            serieDetail?.genres = detail.genres,
            serieDetail?.name = detail.name,
            serieDetail?.networks = detail.networks,
            serieDetail?.originalName = detail.originalName,
            serieDetail?.originalLanguage = detail.originalLanguage,
            serieDetail?.originalTitle = detail.originalTitle,
            serieDetail?.overview = detail.overview,
            serieDetail?.posterPath = detail.posterPath,
            serieDetail?.releaseDate = detail.releaseDate,
            serieDetail?.seasons = detail.seasons,
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

  @override
  Future<Either<MovieError, MovieImagesModel>> fetchImages(int id) async {
    imagesError = null;
    final result = await _repository.fetchImages(id, "tv");
    result.fold(
      (error) => imagesError = error,
      (images) => {
        serieImages = images,
      },
    );

    return result;
  }

  @override
  Future<Either<MovieError, MovieCreditsModel>> fetchCredits(int id) async {
    creditsError = null;
    final result = await _repository.fetchCredits(id, "tv");
    result.fold(
      (error) => creditsError = error,
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
