import 'dart:convert';

import 'package:movies_app/models/genre_model.dart';
import 'package:movies_app/models/network_model.dart';
import 'package:movies_app/models/season_model.dart';

MovieAndSerieDetailModel movieDetailModelFromJson(String str) =>
    MovieAndSerieDetailModel.fromJson(json.decode(str));

String movieDetailModelToJson(MovieAndSerieDetailModel data) =>
    json.encode(data.toJson());

class MovieAndSerieDetailModel {
  // bool adult;
  // String backdropPath;
  // dynamic belongsToCollection;
  int budget;
  List<Genre> genres;

  // String homepage;
  // int id;
  // String imdbId;
  String originalLanguage;
  String originalTitle;
  String originalName;
  String mediaType;
  String overview;

  // double popularity;
  String posterPath;

  // List<ProductionCompany> productionCompanies;
  // List<ProductionCountry> productionCountries;
  String releaseDate;

  // int revenue;
  int runtime;

  // List<SpokenLanguage> spokenLanguages;
  // String status;
  // String tagline;
  String title;
  String name;
  List<Network> networks;
  List<Season> seasons;

  // bool video;
  double voteAverage;

  // int voteCount;

  MovieAndSerieDetailModel({
    // required this.adult,
    // required this.backdropPath,
    // required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.mediaType,
    // required this.homepage,
    // required this.id,
    // required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.originalName,
    required this.overview,
    // required this.popularity,
    required this.posterPath,
    // required this.productionCompanies,
    // required this.productionCountries,
    required this.releaseDate,
    // required this.revenue,
    required this.runtime,
    // required this.spokenLanguages,
    // required this.status,
    // required this.tagline,
    required this.title,
    required this.name,
    required this.networks,
    required this.seasons,
    // required this.video,
    required this.voteAverage,
    // required this.voteCount,
  });

  factory MovieAndSerieDetailModel.fromJson(Map<dynamic, dynamic> json) =>
      MovieAndSerieDetailModel(
        // adult: json["adult"],
        // backdropPath: json["backdrop_path"],
        // belongsToCollection: json["belongs_to_collection"],
        budget: json["budget"] ?? 0,
        genres: json["genres"] != null
            ? List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x)))
            : <Genre>[],
        // homepage: json["homepage"],
        // id: json["id"],
        // imdbId: json["imdb_id"],
        originalLanguage: json["original_language"] ?? "",
        mediaType: json["media_type"] ?? "",
        originalTitle: json["original_title"] ?? "",
        originalName: json["original_name"] ?? "",
        overview: json["overview"] ?? "",
        // popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"] ?? "",
        // productionCompanies: List<ProductionCompany>.from(
        //     json["production_companies"]
        //         .map((x) => ProductionCompany.fromJson(x))),
        // productionCountries: List<ProductionCountry>.from(
        //     json["production_countries"]
        //         .map((x) => ProductionCountry.fromJson(x))),
        releaseDate: json["release_date"] ?? "",
        // revenue: json["revenue"],
        runtime: json["runtime"] ?? 0,
        // spokenLanguages: List<SpokenLanguage>.from(
        //     json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x))),
        // status: json["status"],
        // tagline: json["tagline"],
        title: json["title"] ?? "",
        name: json["name"] ?? "",
        networks: json["networks"] != null
            ? List<Network>.from(
                json["networks"].map((x) => Network.fromJson(x)))
            : <Network>[],
        seasons: json["seasons"] != null
            ? List<Season>.from(json["seasons"].map((x) => Season.fromJson(x)))
            : <Season>[],
        // video: json["video"],
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,

        // voteCount: json["vote_count"],
      );

  Map<dynamic, dynamic> toJson() => {
        // "adult": adult,
        // "backdrop_path": backdropPath,
        // "belongs_to_collection": belongsToCollection,
        "budget": budget,
        "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        // "homepage": homepage,
        // "id": id,
        // "imdb_id": imdbId,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "media_type": mediaType,
        "original_name": originalName,
        "overview": overview,
        // "popularity": popularity,
        "poster_path": posterPath,
        // "production_companies":
        //     List<dynamic>.from(productionCompanies.map((x) => x.toJson())),
        // "production_countries":
        //     List<dynamic>.from(productionCountries.map((x) => x.toJson())),
        "release_date": releaseDate,
        // "revenue": revenue,
        "runtime": runtime,
        // "spoken_languages":
        //     List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
        // "status": status,
        // "tagline": tagline,
        "title": title,
        "name": name,
        "networks": List<dynamic>.from(networks.map((x) => x.toJson())),
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
        // "video": video,
        "vote_average": voteAverage,
        // "vote_count": voteCount,
      };
}
