import 'package:dartz/dartz.dart';
import 'package:movies_app/errors/movie_error.dart';
import 'package:movies_app/models/movie_detail.dart';
import 'package:movies_app/respositories.dart';

class MovieDetailController {
  final _repository = MovieRepository();

  late MovieDetailModel movieDetail;
  late MovieError movieError;
  bool loading = true;

  Future<Either<MovieError, MovieDetailModel>> fetchMovieById(id) async {
    final result = await _repository.fetchMovieById(id);
    result.fold(
      (error) => movieError = error,
      (detail) => {
        movieDetail = detail,
      },
    );
    return result;
  }
}
