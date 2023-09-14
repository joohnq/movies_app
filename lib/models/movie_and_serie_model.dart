import 'dart:convert';

import 'package:movies_app/models/genre_model.dart';

MovieAndSerieModel movieModelFromJson(String str) =>
    MovieAndSerieModel.fromJson(json.decode(str));

String movieModelToJson(MovieAndSerieModel data) => json.encode(data.toJson());

class MovieAndSerieModel {
  String backdropPath;
  int id;
  List<Genre> genres;
  String mediaType;
  String name;
  String originalName;
  String originalTitle;
  String overview;
  String posterPath;
  String title;
  double voteAverage;
  // bool adult;
  // BelongsToCollection belongsToCollection;
  // int budget;
  // String homepage;
  // String imdbId;
  // String originalLanguage;
  // double popularity;
  // List<ProductionCompany> productionCompanies;
  // List<ProductionCountry> productionCountries;
  // DateTime releaseDate;
  // int revenue;
  // int runtime;
  // List<SpokenLanguage> spokenLanguages;
  // String status;
  // String tagline;
  // bool video;
  // int voteCount;

  MovieAndSerieModel({
    required this.backdropPath,
    required this.id,
    required this.genres,
    required this.mediaType,
    required this.name,
    required this.originalName,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
    // required this.adult,
    // required this.belongsToCollection,
    // required this.budget,
    // required this.homepage,
    // required this.imdbId,
    // required this.originalLanguage,
    // required this.overview,
    // required this.popularity,
    // required this.productionCompanies,
    // required this.productionCountries,
    // required this.releaseDate,
    // required this.revenue,
    // required this.runtime,
    // required this.spokenLanguages,
    // required this.status,
    // required this.tagline,
    // required this.video,
    // required this.voteCount,
  });

  factory MovieAndSerieModel.fromJson(Map<dynamic, dynamic> json) =>
      MovieAndSerieModel(
        backdropPath: json["backdrop_path"] ?? "",
        id: json["id"] ?? 0,
        genres: json["genres"] != null
            ? List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x)))
            : <Genre>[],
        mediaType: json["media_type"] ?? "",
        name: json["name"] ?? "",
        originalName: json["original_name"] ?? "",
        originalTitle: json["original_title"] ?? "",
        overview: json["overview"] ?? "",
        posterPath: json["poster_path"] ?? "",
        title: json["title"] ?? "",
        voteAverage: json["vote_average"]?.toDouble() ?? 10.0,
        // adult: json["adult"],
        // belongsToCollection:
        //     BelongsToCollection.fromJson(json["belongs_to_collection"]),
        // budget: json["budget"] ?? 0,
        // homepage: json["homepage"],
        // imdbId: json["imdb_id"],
        // originalLanguage: json["original_language"] ?? "",
        // overview: json["overview"] ?? "",
        // popularity: json["popularity"]?.toDouble(),
        // productionCompanies: List<ProductionCompany>.from(
        //     json["production_companies"]
        //         .map((x) => ProductionCompany.fromJson(x))),
        // productionCountries: List<ProductionCountry>.from(
        //     json["production_countries"]
        //         .map((x) => ProductionCountry.fromJson(x))),
        // releaseDate: json["release_date"] != null
        //     ? DateTime.parse(json["release_date"])
        //     : DateTime(0),
        // revenue: json["revenue"],
        // runtime: json["runtime"] ?? 0,
        // spokenLanguages: json["spoken_languages"] == null
        //     ? List<SpokenLanguage>.from(
        //         json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x)))
        //     : <SpokenLanguage>[],
        // status: json["status"],
        // tagline: json["tagline"],
        // video: json["video"],
        // voteCount: json["vote_count"],
      );

  Map<dynamic, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "id": id,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        "media_type": mediaType,
        "name": name,
        "original_title": originalTitle,
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "title": title,
        "vote_average": voteAverage,
        // "adult": adult,
        // "belongs_to_collection": belongsToCollection.toJson(),
        // "budget": budget,
        // "homepage": homepage,
        // "imdb_id": imdbId,
        // "original_language": originalLanguage,
        // "overview": overview,
        // "popularity": popularity,
        // "production_companies":
        //     List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        // "production_countries":
        //     List<dynamic>.from(productionCountries.map((x) => x.toJson())),
        // "release_date":
        // "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        // "revenue": revenue,
        // "runtime": runtime,
        // "spoken_languages":
        //     List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
        // "status": status,
        // "tagline": tagline,
        // "video": video,
        // "vote_count": voteCount,
      };
}
