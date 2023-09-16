import 'dart:convert';

import 'package:movies_app/models/genre_model.dart';
import 'package:movies_app/models/network_model.dart';
import 'package:movies_app/models/season_model.dart';

MovieAndSerieDetailModel movieDetailModelFromJson(String str) =>
    MovieAndSerieDetailModel.fromJson(json.decode(str));

String movieDetailModelToJson(MovieAndSerieDetailModel data) =>
    json.encode(data.toJson());

class MovieAndSerieDetailModel {
  int budget;
  List<Genre> genres;
  int id;
  String mediaType;
  String name;
  List<Network> networks;
  String originalLanguage;
  String originalTitle;
  String originalName;
  String overview;
  String posterPath;
  String releaseDate;
  int runtime;
  List<Season> seasons;
  String title;
  double voteAverage;
  // bool adult;
  // String backdropPath;
  // dynamic belongsToCollection;
  // String homepage;
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

  MovieAndSerieDetailModel({
    required this.budget,
    required this.genres,
    required this.id,
    required this.mediaType,
    required this.name,
    required this.networks,
    required this.originalLanguage,
    required this.originalTitle,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.seasons,
    required this.title,
    required this.voteAverage,
    // required this.adult,
    // required this.backdropPath,
    // required this.belongsToCollection,
    // required this.homepage,
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

  factory MovieAndSerieDetailModel.fromJson(Map<dynamic, dynamic> json) =>
      MovieAndSerieDetailModel(
        budget: json["budget"] ?? 0,
        genres: json["genres"] != null
            ? List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x)))
            : <Genre>[],
        id: json["id"] ?? 0,
        mediaType: json["media_type"] ?? "",
        name: json["name"] ?? "",
        networks: json["networks"] != null
            ? List<Network>.from(
                json["networks"].map((x) => Network.fromJson(x)))
            : <Network>[],
        originalLanguage: json["original_language"] ?? "",
        originalTitle: json["original_title"] ?? "",
        originalName: json["original_name"] ?? "",
        overview: json["overview"] ?? "",
        posterPath: json["poster_path"] ?? "",
        releaseDate: json["release_date"] ?? "",
        runtime: json["runtime"] ?? 0,
        seasons: json["seasons"] != null
            ? List<Season>.from(json["seasons"].map((x) => Season.fromJson(x)))
            : <Season>[],
        title: json["title"] ?? "",
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        // adult: json["adult"],
        // backdropPath: json["backdrop_path"],
        // belongsToCollection: json["belongs_to_collection"],
        // homepage: json["homepage"],
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
        "id": id,
        "media_type": mediaType,
        "name": name,
        "networks": List<dynamic>.from(networks.map((x) => x.toJson())),
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "original_name": originalName,
        "overview": overview,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "runtime": runtime,
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        "title": title,
        "vote_average": voteAverage,
        // "adult": adult,
        // "backdrop_path": backdropPath,
        // "belongs_to_collection": belongsToCollection,
        // "homepage": homepage,
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
