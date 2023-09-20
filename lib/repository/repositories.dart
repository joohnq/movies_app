// ignore_for_file: avoid_print
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/core/api.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/movie_and_serie_detail_model.dart';
import 'package:movies_app/models/movie_and_serie_model.dart';
import 'package:movies_app/models/movie_and_serie_response_model.dart';
import 'package:movies_app/models/movie_credits_model.dart';
import 'package:movies_app/models/movie_images_model.dart';

class MovieRepository {
  final Dio _dio = Dio(kDioOption);

  Future<Either<MovieError, MovieAndSerieResponseModel>> fetchPopular(
    int page,
    String mediaType,
  ) async {
    try {
      final response =
          await _dio.get('/$mediaType/popular?page=$page&language=en-US');
      final model = MovieAndSerieResponseModel.fromJson(response.data);
      return Right(model);
    } on DioException catch (error) {
      if (error.response != null) {
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

  Future<Either<MovieError, MovieAndSerieResponseModel>> fetchTrending(
      int page, String mediaType) async {
    try {
      final response =
          await _dio.get('/trending/$mediaType/day?page=$page&language=en-US');
      final model = MovieAndSerieResponseModel.fromJson(response.data);
      return Right(model);
    } on DioException catch (error) {
      if (error.response != null) {
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

  Future<Either<MovieError, MovieAndSerieModel>> fetchEmphasis(
      int page, String mediaType) async {
    try {
      final response =
          await _dio.get('/$mediaType/popular?page=$page&language=en-US');
      final model = MovieAndSerieResponseModel.fromJson(response.data);
      return Right(model.results[0]);
    } on DioException catch (error) {
      if (error.response != null) {
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

  Future<Either<MovieError, MovieAndSerieResponseModel>> fetchByName(
      int page, String title) async {
    try {
      final response = await _dio
          .get('/search/multi?query=$title&include_adult=true&page=$page');
      final model = MovieAndSerieResponseModel.fromJson(response.data);
      return Right(model);
    } on DioException catch (error) {
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

  Future<Either<MovieError, MovieAndSerieDetailModel>> fetchById(
      int id, String mediaType, String title) async {
    try {
      final response = await _dio.get('/movie/$id?language=en-US');
      final model = MovieAndSerieDetailModel.fromJson(response.data);
      if (model.originalTitle == title ||
          model.title == title ||
          model.name == title ||
          model.originalName == title) {
        return Right(model);
      } else {
        final response = await _dio.get('/tv/$id?language=en-US');
        final model = MovieAndSerieDetailModel.fromJson(response.data);
        return Right(model);
      }
    } on DioException catch (error) {
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

  Future<Either<MovieError, MovieImagesModel>> fetchImages(
      int id, String mediaType) async {
    try {
      final response = await _dio.get('/$mediaType/$id/images');
      final model = MovieImagesModel.fromJson(response.data);
      return Right(model);
    } on DioException catch (error) {
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

  Future<Either<MovieError, MovieCreditsModel>> fetchCredits(
      int id, mediaType) async {
    try {
      final response = await _dio.get('/$mediaType/$id/credits?language=en-US');
      final model = MovieCreditsModel.fromJson(response.data);
      return Right(model);
    } on DioException catch (error) {
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

  Future<Either<MovieError, MovieAndSerieDetailModel>> fetchFavoritesDetails(
      String id, String mediaType) async {
    final Dio dio = Dio(kDioOption);

    try {
      final response = await dio.get('/$mediaType/$id?language=en-US');
      final model = MovieAndSerieDetailModel.fromJson(response.data);
      model.mediaType = mediaType;
      return Right(model);
    } on DioException catch (error) {
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
    } catch (error) {
      return Left(
        MovieRepositoryError(
          error.toString(),
        ),
      );
    }
  }

  // Future<Either<MovieError, List<MovieAndSerieDetailModel>>>
  //     fetchFavoritesDetails(List<String> favorites) async {
  //   final Dio dio = Dio(kDioOption);
  //   List<MovieAndSerieDetailModel> details = [];
  //
  //   for (String favorite in favorites) {
  //     Map<dynamic, dynamic> jsonData = json.decode(favorite);
  //
  //     FavouriteModel item = FavouriteModel(
  //       id: jsonData['id'],
  //       mediaType: jsonData['mediaType'],
  //     );
  //
  //     try {
  //       final response =
  //           await dio.get('/${item.mediaType}/${item.id}?language=en-US');
  //       final model = MovieAndSerieDetailModel.fromJson(response.data);
  //       model.mediaType = item.mediaType;
  //       details.add(model);
  //     } on DioException catch (error) {
  //       if (error.response != null) {
  //         return Left(
  //           MovieRepositoryError(
  //             error.response!.data['status_message'],
  //           ),
  //         );
  //       } else {
  //         return Left(
  //           MovieRepositoryError(kServerError),
  //         );
  //       }
  //     } catch (error) {
  //       return Left(
  //         MovieRepositoryError(
  //           error.toString(),
  //         ),
  //       );
  //     }
  //   }
  //
  //   if (details.isNotEmpty) {
  //     return Right(details);
  //   } else {
  //     return Left(
  //       MovieRepositoryError('No details found for favorites.'),
  //     );
  //   }
  // }
}
