import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/core/api.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/movie_credits_model.dart';
import 'package:movies_app/models/movie_detail_model.dart';
import 'package:movies_app/models/movie_images_model.dart';
import 'package:movies_app/models/movie_response_model.dart';

class MovieRepository {
  final Dio _dio = Dio(kDioOption);

  Future<Either<MovieError, MovieResponseModel>> fetchPopularMovies(
      int page) async {
    try {
      final response = await _dio.get('/movie/popular?page=$page');
      final model = MovieResponseModel.fromJson(response.data);
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
}
