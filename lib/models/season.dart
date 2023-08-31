class Season {
  DateTime airDate;
  int episodeCount;
  String name;
  String posterPath;
  int seasonNumber;

  Season({
    required this.airDate,
    required this.episodeCount,
    required this.name,
    required this.posterPath,
    required this.seasonNumber,
  });

  factory Season.fromJson(Map<dynamic, dynamic> json) => Season(
        airDate: DateTime.parse(json["air_date"]),
        episodeCount: json["episode_count"],
        name: json["name"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<dynamic, dynamic> toJson() => {
        "air_date":
            "${airDate.year.toString().padLeft(4, '0')}-${airDate.month.toString().padLeft(2, '0')}-${airDate.day.toString().padLeft(2, '0')}",
        "episode_count": episodeCount,
        "name": name,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };
}
