import 'dart:convert';

MoviesAndSeries moviesApiFromJson(String str) =>
    MoviesAndSeries.fromJson(json.decode(str));

String moviesApiToJson(MoviesAndSeries data) => json.encode(data.toJson());

class MoviesAndSeries {
  List<Result> results;

  MoviesAndSeries({
    required this.results,
  });

  factory MoviesAndSeries.fromJson(Map<dynamic, dynamic> json) =>
      MoviesAndSeries(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  String backdropPath;
  List<Genre>? genres;
  List<int>? genreIds;
  int id;
  String? originalTitle;
  String overview;
  String posterPath;
  String title;
  double voteAverage;
  String? name;
  List<Network>? networks;
  String? originalName;
  List<Season>? seasons;

  Result({
    required this.backdropPath,
    this.genres,
    this.genreIds,
    required this.id,
    this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
    this.name,
    this.networks,
    this.originalName,
    this.seasons,
  });

  factory Result.fromJson(Map<dynamic, dynamic> json) => Result(
        backdropPath: json["backdrop_path"] ?? "",
        genres: json["genres"] != null
            ? List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x)))
            : [],
        genreIds: json["genre_ids"] != null
            ? List<int>.from(json["genre_ids"].map((x) => x))
            : [],
        id: json["id"],
        originalTitle: json["original_title"] ?? "",
        overview: json["overview"] ?? "",
        posterPath: json["poster_path"] ?? "",
        title: json["title"] ?? "",
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        name: json["name"] ?? "",
        networks: json["networks"] != null
            ? List<Network>.from(
                json["networks"].map((x) => Network.fromJson(x)))
            : [],
        originalName: json["original_name"] ?? "",
        seasons: json["seasons"] != null
            ? List<Season>.from(json["seasons"].map((x) => Season.fromJson(x)))
            : [],
      );

  Map<dynamic, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "genres": List<dynamic>.from(genres!.map((x) => x.toJson())),
        "genre_ids": List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "title": title,
        "vote_average": voteAverage,
        "name": name,
        "networks": List<dynamic>.from(networks!.map((x) => x.toJson())),
        "original_name": originalName,
        "seasons": List<dynamic>.from(seasons!.map((x) => x.toJson())),
      };
}

class Genre {
  int id;
  String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<dynamic, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Network {
  int id;
  String logoPath;
  String name;
  String originCountry;

  Network({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
      };
}

class Season {
  DateTime airDate;
  int episodeCount;
  int id;
  String name;
  String overview;
  String posterPath;
  int seasonNumber;
  double voteAverage;

  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        airDate: DateTime.parse(json["air_date"]),
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        voteAverage: json["vote_average"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episode_count": episodeCount,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "vote_average": voteAverage,
      };
}
