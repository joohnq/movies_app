import 'dart:convert';

import 'package:movies_app/models/movie.dart';

MovieResponseModel movieResponseModelFromJson(String str) =>
    MovieResponseModel.fromJson(json.decode(str));

String movieResponseModelToJson(MovieResponseModel data) =>
    json.encode(data.toJson());

class MovieResponseModel {
  int page;
  List<MovieModel> results;
  int totalPages;
  int totalResults;

  MovieResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponseModel.fromJson(Map<dynamic, dynamic> json) =>
      MovieResponseModel(
        page: json["page"],
        results: List<MovieModel>.from(
            json["results"].map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<dynamic, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
