import 'dart:convert';

import 'package:movies_app/models/movie_and_serie_model.dart';

MovieAndSerieResponseModel movieResponseModelFromJson(String str) =>
    MovieAndSerieResponseModel.fromJson(json.decode(str));

String movieResponseModelToJson(MovieAndSerieResponseModel data) =>
    json.encode(data.toJson());

class MovieAndSerieResponseModel {
  int page;
  List<MovieAndSerieModel> results;
  int totalPages;
  int totalResults;

  MovieAndSerieResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieAndSerieResponseModel.fromJson(Map<dynamic, dynamic> json) =>
      MovieAndSerieResponseModel(
        page: json["page"] ?? 1,
        results: List<MovieAndSerieModel>.from(
            json["results"].map((x) => MovieAndSerieModel.fromJson(x))),
        totalPages: json["total_pages"] ?? 1,
        totalResults: json["total_results"] ?? 1,
      );

  Map<dynamic, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
