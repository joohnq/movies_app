import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/core/api.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/movie_and_serie_detail_model.dart';
import 'package:movies_app/models/movie_and_serie_model.dart';
import 'package:movies_app/models/movie_and_serie_response_model.dart';
import 'package:movies_app/models/movie_credits_model.dart';
import 'package:movies_app/models/movie_detail_model.dart';
import 'package:movies_app/models/movie_images_model.dart';

class MovieRepository {
  final Dio _dio = Dio(kDioOption);

  Future<Either<MovieError, MovieAndSerieResponseModel>> fetchPopularMovies(
      int page) async {
    try {
      final response = await _dio.get('/movie/popular?page=$page');
      final model = MovieAndSerieResponseModel.fromJson(response.data);
      return Right(model);
    } catch (error) {
      if (error != null) {
        return Left(
          MovieRepositoryError(
            error.toString(),
          ),
        );
      } else {
        return Left(
          MovieRepositoryError(kServerError),
        );
      }
    }
  }

  Future<Either<MovieError, MovieAndSerieResponseModel>> fetchPopularSeries(
      int page) async {
    try {
      final response = await _dio.get('/tv/popular?page=$page');
      final model = MovieAndSerieResponseModel.fromJson(response.data);
      return Right(model);
    } catch (error) {
      if (error != null) {
        return Left(
          MovieRepositoryError(
            error.toString(),
          ),
        );
      } else {
        return Left(
          MovieRepositoryError(kServerError),
        );
      }
    }
  }

  Future<Either<MovieError, MovieAndSerieResponseModel>> fetchTrendingMovies(
      int page) async {
    try {
      final response = await _dio.get('/trending/movie/day?page=$page');
      final model = MovieAndSerieResponseModel.fromJson(response.data);
      return Right(model);
    } catch (error) {
      if (error != null) {
        return Left(
          MovieRepositoryError(
            error.toString(),
          ),
        );
      } else {
        return Left(
          MovieRepositoryError(kServerError),
        );
      }
    }
  }

  Future<Either<MovieError, MovieAndSerieResponseModel>> fetchTrendingSeries(
      int page) async {
    try {
      final response = await _dio.get('/trending/tv/day?page=$page');
      final model = MovieAndSerieResponseModel.fromJson(response.data);
      return Right(model);
    } catch (error) {
      if (error != null) {
        return Left(
          MovieRepositoryError(
            error.toString(),
          ),
        );
      } else {
        return Left(
          MovieRepositoryError(kServerError),
        );
      }
    }
  }

  Future<Either<MovieError, MovieAndSerieModel>> fetchEmphasis(int page) async {
    try {
      final response = await _dio.get('/movie/popular?page=$page');
      final model = MovieAndSerieResponseModel.fromJson(response.data);
      return Right(model.results[0]);
    } catch (error) {
      if (error != null) {
        return Left(
          MovieRepositoryError(
            error.toString(),
          ),
        );
      } else {
        return Left(
          MovieRepositoryError(kServerError),
        );
      }
    }
  }

  Future<Either<MovieError, MovieAndSerieModel>> fetchSeriesEmphasis(
      int page) async {
    try {
      final response = await _dio.get('/tv/popular?page=$page');
      final model = MovieAndSerieResponseModel.fromJson(response.data);
      return Right(model.results[0]);
    } catch (error) {
      if (error != null) {
        return Left(
          MovieRepositoryError(
            error.toString(),
          ),
        );
      } else {
        return Left(
          MovieRepositoryError(kServerError),
        );
      }
    }
  }

  Future<Either<MovieError, MovieDetailModel>> fetchMovieById(int id) async {
    try {
      final response = await _dio.get('/movie/$id');
      final model = MovieDetailModel.fromJson(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(
          MovieRepositoryError(
            error.response!.data['status_message'],
          ),
        );
      } else {
        return Left(
          MovieRepositoryError(kServerError),
        );
      }
    } on Exception catch (error) {
      return Left(
        MovieRepositoryError(
          error.toString(),
        ),
      );
    }
  }

  Future<Either<MovieError, MovieAndSerieDetailModel>> fetchSerieById(
      int id) async {
    try {
      final response = await _dio.get('/tv/$id');
      final model = MovieAndSerieDetailModel.fromJson(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(
          MovieRepositoryError(
            error.response!.data['status_message'],
          ),
        );
      } else {
        return Left(
          MovieRepositoryError(kServerError),
        );
      }
    } on Exception catch (error) {
      return Left(
        MovieRepositoryError(
          error.toString(),
        ),
      );
    }
  }

  Future<Either<MovieError, MovieImagesModel>> fetchMovieImages(int id) async {
    try {
      final response = await _dio.get('/movie/$id/images');
      final model = MovieImagesModel.fromJson(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(
          MovieRepositoryError(
            error.response!.data['status_message'],
          ),
        );
      } else {
        return Left(
          MovieRepositoryError(kServerError),
        );
      }
    } on Exception catch (error) {
      return Left(
        MovieRepositoryError(
          error.toString(),
        ),
      );
    }
  }

  Future<Either<MovieError, MovieImagesModel>> fetchSerieImages(int id) async {
    try {
      final response = await _dio.get('/tv/$id/images');
      final model = MovieImagesModel.fromJson(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(
          MovieRepositoryError(
            error.response!.data['status_message'],
          ),
        );
      } else {
        return Left(
          MovieRepositoryError(kServerError),
        );
      }
    } on Exception catch (error) {
      return Left(
        MovieRepositoryError(
          error.toString(),
        ),
      );
    }
  }

  Future<Either<MovieError, MovieCreditsModel>> fetchMovieCredits(
      int id) async {
    try {
      final response = await _dio.get('/movie/$id/credits');
      final model = MovieCreditsModel.fromJson(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(
          MovieRepositoryError(
            error.response!.data['status_message'],
          ),
        );
      } else {
        return Left(
          MovieRepositoryError(kServerError),
        );
      }
    } on Exception catch (error) {
      return Left(
        MovieRepositoryError(
          error.toString(),
        ),
      );
    }
  }

  Future<Either<MovieError, MovieCreditsModel>> fetchSerieCredits(
      int id) async {
    try {
      final response = await _dio.get('/tv/$id/credits');
      final model = MovieCreditsModel.fromJson(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(
          MovieRepositoryError(
            error.response!.data['status_message'],
          ),
        );
      } else {
        return Left(
          MovieRepositoryError(kServerError),
        );
      }
    } on Exception catch (error) {
      return Left(
        MovieRepositoryError(
          error.toString(),
        ),
      );
    }
  }
}
