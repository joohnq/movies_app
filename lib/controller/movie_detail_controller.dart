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

class MovieDetailController extends BaseDetailController {
  final _repository = MovieRepository();

  MovieAndSerieDetailModel? movieDetail;
  MovieError? detailError;

  MovieImagesModel? movieImages;
  MovieError? imagesError;

  MovieCreditsModel? movieCredits;
  MovieError? creditsError;

  @override
  int get budget => movieDetail?.budget ?? 0;
  @override
  List<Genre> get genres => movieDetail?.genres ?? <Genre>[];
  @override
  String get originalLanguage => movieDetail?.originalLanguage ?? "";
  @override
  String get originalTitle => movieDetail?.originalTitle ?? "";
  @override
  String get overview => movieDetail?.overview ?? "";
  @override
  String get posterPath => movieDetail?.posterPath ?? "";
  @override
  String get releaseDate => movieDetail?.releaseDate ?? "";
  @override
  int get runtime => movieDetail?.runtime ?? 0;
  @override
  String get title => movieDetail?.title ?? "";
  @override
  String get name => movieDetail?.name ?? "";
  @override
  String get originalName => movieDetail?.originalName ?? "";
  @override
  String get voteAverage => movieDetail?.voteAverage.toStringAsFixed(1) ?? "";
  @override
  String get mediaType => movieDetail?.mediaType ?? "";
  @override
  List<Network> get networks => <Network>[];
  @override
  List<Season> get seasons => <Season>[];

  @override
  List<Backdrop> get images =>
      movieImages?.backdrops.take(10).toList() ?? <Backdrop>[];
  @override
  int get imagesCount => images.take(10).length;

  @override
  List<Cast> get cast => movieCredits?.cast ?? <Cast>[];
  @override
  List<Cast> get crew => movieCredits?.crew ?? <Cast>[];

  @override
  Future<Either<MovieError, MovieAndSerieDetailModel>> fetchById(
      int id, String title) async {
    detailError = null;
    final result = await _repository.fetchById(id, "movie", title);
    result.fold(
      (error) => detailError = error,
      (detail) => {
        if (movieDetail != null)
          {
            movieDetail?.budget = detail.budget,
            movieDetail?.genres = detail.genres,
            movieDetail?.originalLanguage = detail.originalLanguage,
            movieDetail?.originalTitle = detail.originalTitle,
            movieDetail?.originalName = detail.originalName,
            movieDetail?.overview = detail.overview,
            movieDetail?.posterPath = detail.posterPath,
            movieDetail?.releaseDate = detail.releaseDate,
            movieDetail?.title = detail.title,
            movieDetail?.name = detail.name,
            movieDetail?.voteAverage = detail.voteAverage,
            movieDetail?.mediaType = detail.mediaType,
          }
        else
          {
            movieDetail = detail,
          },
      },
    );

    return result;
  }

  @override
  Future<Either<MovieError, MovieImagesModel>> fetchImages(int id) async {
    imagesError = null;
    final result = await _repository.fetchImages(id, "movie");
    result.fold(
      (error) => imagesError = error,
      (images) => {
        movieImages = images,
      },
    );

    return result;
  }

  @override
  Future<Either<MovieError, MovieCreditsModel>> fetchCredits(int id) async {
    creditsError = null;
    final result = await _repository.fetchCredits(id, "movie");
    result.fold(
      (error) => creditsError = error,
      (credits) => {
        if (movieCredits != null)
          {
            movieCredits?.cast = credits.cast,
            movieCredits?.crew = credits.crew,
          }
        else
          {
            movieCredits = credits,
          },
      },
    );

    return result;
  }
}
