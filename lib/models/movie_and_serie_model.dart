import 'dart:convert';

MovieAndSerieModel movieModelFromJson(String str) =>
    MovieAndSerieModel.fromJson(json.decode(str));

String movieModelToJson(MovieAndSerieModel data) => json.encode(data.toJson());

class MovieAndSerieModel {
  // bool adult;
  String backdropPath;

  // BelongsToCollection belongsToCollection;
  // int budget;
  // List<Genre> genres;
  // String homepage;
  int id;

  // String imdbId;
  // String originalLanguage;
  String originalTitle;

  // String overview;
  // double popularity;
  String posterPath;

  // List<ProductionCompany> productionCompanies;
  // List<ProductionCountry> productionCountries;
  // DateTime releaseDate;
  // int revenue;
  // int runtime;
  // List<SpokenLanguage> spokenLanguages;
  // String status;
  // String tagline;
  String mediaType;
  String name;
  String originalName;
  String title;

  // bool video;
  double voteAverage;

  // int voteCount;

  MovieAndSerieModel({
    // required this.adult,
    required this.backdropPath,
    // required this.belongsToCollection,
    // required this.budget,
    // required this.genres,
    // required this.homepage,
    required this.id,
    // required this.imdbId,
    // required this.originalLanguage,
    required this.originalTitle,
    // required this.overview,
    // required this.popularity,
    required this.posterPath,
    // required this.productionCompanies,
    // required this.productionCountries,
    // required this.releaseDate,
    // required this.revenue,
    // required this.runtime,
    // required this.spokenLanguages,
    // required this.status,
    // required this.tagline,
    required this.mediaType,
    required this.name,
    required this.originalName,
    required this.title,
    // required this.video,
    required this.voteAverage,
    // required this.voteCount,
  });

  factory MovieAndSerieModel.fromJson(Map<dynamic, dynamic> json) =>
      MovieAndSerieModel(
        // adult: json["adult"],
        backdropPath: json["backdrop_path"] ?? "",
        // belongsToCollection:
        //     BelongsToCollection.fromJson(json["belongs_to_collection"]),
        // budget: json["budget"] ?? 0,
        // genres: json["genres"] != null
        //     ? List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x)))
        //     : <Genre>[],
        // homepage: json["homepage"],
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        mediaType: json["media_type"] ?? "",
        // imdbId: json["imdb_id"],
        // originalLanguage: json["original_language"] ?? "",
        originalName: json["original_name"] ?? "",
        originalTitle: json["original_title"] ?? "",
        // overview: json["overview"] ?? "",
        // popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"] ?? "",
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
        title: json["title"] ?? "",
        // video: json["video"],
        voteAverage: json["vote_average"]?.toDouble() ?? 10.0,
        // voteCount: json["vote_count"],
      );

  Map<dynamic, dynamic> toJson() => {
        // "adult": adult,
        "backdrop_path": backdropPath,
        // "belongs_to_collection": belongsToCollection.toJson(),
        // "budget": budget,
        // "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
        // "homepage": homepage,
        "id": id,
        "name": name,
        "media_type": mediaType,
        // "imdb_id": imdbId,
        // "original_language": originalLanguage,
        "original_title": originalTitle,
        // "overview": overview,
        // "popularity": popularity,
        "poster_path": posterPath,
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
        "title": title,
        // "video": video,
        "vote_average": voteAverage,
        // "vote_count": voteCount,
      };
}
