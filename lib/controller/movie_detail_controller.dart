import 'package:dartz/dartz.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/backdrop_model.dart';
import 'package:movies_app/models/cast_model.dart';
import 'package:movies_app/models/genre_model.dart';
import 'package:movies_app/models/movie_credits_model.dart';
import 'package:movies_app/models/movie_detail_model.dart';
import 'package:movies_app/models/movie_images_model.dart';
import 'package:movies_app/repository/repositories.dart';

class MovieDetailController {
  final _repository = MovieRepository();

  MovieDetailModel? movieDetail;
  MovieError? movieDetailError;
  bool movieDetailLoading = true;

  MovieImagesModel? movieImages;
  MovieError? movieImagesError;
  bool movieImagesLoading = true;

  MovieCreditsModel? movieCredits;
  MovieError? movieCreditsError;
  bool movieCreditsLoading = true;

  int get budget => movieDetail?.budget ?? 0;
  List<Genre> get genres => movieDetail?.genres ?? <Genre>[];
  String get originalLanguage => movieDetail?.originalLanguage ?? "";
  String get originalTitle => movieDetail?.originalTitle ?? "";
  String get overview => movieDetail?.overview ?? "";
  String get posterPath => movieDetail?.posterPath ?? "";
  String get releaseDate => movieDetail?.releaseDate ?? "";
  int get runtime => movieDetail?.runtime ?? 0;
  String get title => movieDetail?.title ?? "";
  String get voteAverage => movieDetail?.voteAverage.toStringAsFixed(1) ?? "";

  List<Backdrop> get images =>
      movieImages?.backdrops.take(10).toList() ?? <Backdrop>[];
  int get imagesCount => images.take(10).length;

  List<Cast> get cast => movieCredits?.cast ?? <Cast>[];
  List<Cast> get crew => movieCredits?.crew ?? <Cast>[];

  Future<Either<MovieError, MovieDetailModel>> fetchMovieById(int id) async {
    movieDetailError = null;
    final result = await _repository.fetchMovieById(id);
    result.fold(
      (error) => movieDetailError = error,
      (detail) => {
        if (movieDetail != null)
          {
            movieDetail?.budget = detail.budget,
            movieDetail?.genres = detail.genres,
            movieDetail?.originalLanguage = detail.originalLanguage,
            movieDetail?.originalTitle = detail.originalTitle,
            movieDetail?.overview = detail.overview,
            movieDetail?.posterPath = detail.posterPath,
            movieDetail?.releaseDate = detail.releaseDate,
            movieDetail?.title = detail.title,
            movieDetail?.voteAverage = detail.voteAverage,
          }
        else
          {
            movieDetail = detail,
          },
      },
    );

    return result;
  }

  Future<Either<MovieError, MovieImagesModel>> fetchMovieImages(int id) async {
    movieImagesError = null;
    final result = await _repository.fetchMovieImages(id);
    result.fold(
      (error) => movieImagesError = error,
      (images) => {
        movieImages = images,
      },
    );

    return result;
  }

  Future<Either<MovieError, MovieCreditsModel>> fetchMovieCredits(
      int id) async {
    movieCreditsError = null;
    final result = await _repository.fetchMovieCredits(id);
    result.fold(
      (error) => movieCreditsError = error,
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
