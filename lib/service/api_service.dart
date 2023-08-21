// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/models/credits.dart';
// import 'package:movies_app/models/movie_images.dart';
import 'package:movies_app/models/movies_series.dart';
import 'package:tmdb_api/tmdb_api.dart';

const String baseUrl = 'https://api.themoviedb.org/3/';
final dio = Dio();

class MovieService {
  final TMDB tmdb;

  MovieService()
      : tmdb = TMDB(
          ApiKeys(dotenv.env['API_KEY']!, dotenv.env['API_TOKEN']!),
          logConfig: const ConfigLogger(
            showLogs: true,
            showErrorLogs: true,
          ),
          defaultLanguage: "pt-BR",
        );

  static Future<Result> getWithQuery(String title) async {
    try {
      return MoviesAndSeries.fromJson(
        await MovieService().tmdb.v3.search.queryMulti(
              title,
              includeAdult: true,
              language: 'pt-BR',
            ),
      ).results[0];
    } catch (error) {
      throw Exception(error);
    }
  }

  static Future<MoviesAndSeries> shortly() async {
    try {
      return MoviesAndSeries.fromJson(
        await MovieService().tmdb.v3.movies.getUpcoming(),
      );
    } catch (error) {
      throw Exception("Ocorreu um erro: $error");
    }
  }

  static Future<MoviesAndSeries> trending(int page) async {
    try {
      return MoviesAndSeries.fromJson(
        await MovieService().tmdb.v3.trending.getTrending(page: page),
      );
    } catch (error) {
      throw Exception("Ocorreu um erro: $error");
    }
  }

  static Future<MoviesAndSeries> topRated() async {
    try {
      return MoviesAndSeries.fromJson(
        await MovieService().tmdb.v3.movies.getTopRated(),
      );
    } catch (error) {
      throw Exception("Ocorreu um erro: $error");
    }
  }

  static Future<MoviesAndSeries> searchByCategory(String category) async {
    try {
      final MoviesAndSeries trendingItem;
      if (category == "0") {
        trendingItem = MoviesAndSeries.fromJson(
          await MovieService().tmdb.v3.movies.getNowPlaying(),
        );
      } else if (category == "100") {
        trendingItem = MoviesAndSeries.fromJson(
          await MovieService()
              .tmdb
              .v3
              .trending
              .getTrending(mediaType: MediaType.tv),
        );
      } else {
        trendingItem = MoviesAndSeries.fromJson(
          await MovieService().tmdb.v3.discover.getMovies(withGenres: category),
        );
      }
      return trendingItem;
    } catch (error) {
      throw Exception("Ocorreu um erro: $error");
    }
  }

  static Future<List<Result>> searchByName(String name) async {
    try {
      return MoviesAndSeries.fromJson(
        await MovieService().tmdb.v3.search.queryMulti(name),
      ).results.toList();
    } catch (error) {
      throw Exception("Ocorreu um erro: $error");
    }
  }

  static Future<CreditsModel> credits(int id) async {
    try {
      return CreditsModel.fromJson(
        await MovieService().tmdb.v3.movies.getCredits(id),
      );
    } catch (error) {
      throw Exception("Ocorreu um erro: $error");
    }
  }

  static Future<List<Backdrop>> getImages(int id) async {
    try {
      final response = await dio.get(
        '${baseUrl}tv/$id/images?api_key=${dotenv.env['API_KEY']!}',
      );

      return MovieImages.fromJson(response.data).backdrops;
    } catch (error) {
      try {
        final response = await dio.get(
          '${baseUrl}movie/$id/images?api_key=${dotenv.env['API_KEY']!}',
        );
        return MovieImages.fromJson(response.data).backdrops;
      } catch (error2) {
        throw Exception("Ocorreu um erro: $error2");
      }
    }
  }
}
