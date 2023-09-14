class Season {
  DateTime airDate;
  int episodeCount;
  int id;
  String name;
  String overview;
  dynamic posterPath;
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
        airDate: json["air_date"] != null
            ? DateTime.parse(json["air_date"])
            : DateTime.parse(""),
        episodeCount: json["episode_count"] ?? 0,
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        overview: json["overview"] ?? "",
        posterPath: json["poster_path"] ?? "",
        seasonNumber: json["season_number"] ?? 0,
        voteAverage: json["vote_average"].toDouble() ?? 0.0,
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
