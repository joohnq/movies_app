import 'dart:convert';

import 'package:movies_app/models/genre_model.dart';

MovieDetailModel movieDetailModelFromJson(String str) =>
    MovieDetailModel.fromJson(json.decode(str));

String movieDetailModelToJson(MovieDetailModel data) =>
    json.encode(data.toJson());

class MovieDetailModel {
  int budget;
  List<Genre> genres;
  String originalLanguage;
  String originalTitle;
  String overview;
  String posterPath;
  String releaseDate;
  int runtime;
  String title;
  double voteAverage;
  // bool adult;
  // String backdropPath;
  // dynamic belongsToCollection;
  // String homepage;
  // int id;
  // String imdbId;
  // double popularity;
  // List<ProductionCompany> productionCompanies;
  // List<ProductionCountry> productionCountries;
  // int revenue;
  // List<SpokenLanguage> spokenLanguages;
  // String status;
  // String tagline;
  // bool video;
  // int voteCount;

  MovieDetailModel({
    required this.budget,
    required this.genres,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    // required this.adult,
    // required this.backdropPath,
    // required this.belongsToCollection,
    // required this.homepage,
    // required this.id,
    // required this.imdbId,
    // required this.popularity,
    // required this.productionCompanies,
    // required this.productionCountries,
    // required this.revenue,
    // required this.spokenLanguages,
    // required this.status,
    // required this.tagline,
    // required this.video,
    // required this.voteCount,
  });

  factory MovieDetailModel.fromJson(Map<dynamic, dynamic> json) =>
      MovieDetailModel(
        budget: json["budget"] ?? 0,
        genres: json["genres"] != null
            ? List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x)))
            : <Genre>[],
        originalLanguage: json["original_language"] ?? "",
        originalTitle: json["original_title"] ?? "",
        overview: json["overview"] ?? "",
        posterPath: json["poster_path"] ?? "",
        releaseDate: json["release_date"] ?? "",
        runtime: json["runtime"] ?? "",
        title: json["title"] ?? "",
        voteAverage: json["vote_average"]?.toDouble() ?? 0,
        // adult: json["adult"],
        // backdropPath: json["backdrop_path"],
        // belongsToCollection: json["belongs_to_collection"],
        // homepage: json["homepage"],
        // id: json["id"],
        // imdbId: json["imdb_id"],
        // popularity: json["popularity"]?.toDouble(),
        // productionCompanies: List<ProductionCompany>.from(
        //     json["production_companies"]
        //         .map((x) => ProductionCompany.fromJson(x))),
        // productionCountries: List<ProductionCountry>.from(
        //     json["production_countries"]
        //         .map((x) => ProductionCountry.fromJson(x))),
        // revenue: json["revenue"],
        // spokenLanguages: List<SpokenLanguage>.from(
        //     json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
        // status: json["status"],
        // tagline: json["tagline"],
        // video: json["video"],
        // voteCount: json["vote_count"],
      );

  Map<dynamic, dynamic> toJson() => {
        "budget": budget,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "runtime": runtime,
        "title": title,
        "vote_average": voteAverage,
        // "adult": adult,
        // "backdrop_path": backdropPath,
        // "belongs_to_collection": belongsToCollection,
        // "homepage": homepage,
        // "id": id,
        // "imdb_id": imdbId,
        // "popularity": popularity,
        // "production_companies":
        //     List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        // "production_countries":
        //     List<dynamic>.from(productionCountries.map((x) => x.toJson())),
        // "revenue": revenue,
        // "spoken_languages":
        //     List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
        // "status": status,
        // "tagline": tagline,
        // "video": video,
        // "vote_count": voteCount,
      };
}
