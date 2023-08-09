import 'dart:convert';

MovieImages imagesFromJson(String str) =>
    MovieImages.fromJson(json.decode(str));

String imagesToJson(MovieImages data) => json.encode(data.toJson());

class MovieImages {
  List<Backdrop> backdrops;
  List<Backdrop> posters;

  MovieImages({
    required this.backdrops,
    required this.posters,
  });

  factory MovieImages.fromJson(Map<dynamic, dynamic> json) => MovieImages(
        backdrops: List<Backdrop>.from(
            json["backdrops"].map((x) => Backdrop.fromJson(x))),
        posters: List<Backdrop>.from(
            json["posters"].map((x) => Backdrop.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "backdrops": List<dynamic>.from(backdrops.map((x) => x.toJson())),
        "posters": List<dynamic>.from(posters.map((x) => x.toJson())),
      };
}

class Backdrop {
  String filePath;

  Backdrop({
    required this.filePath,
  });

  factory Backdrop.fromJson(Map<dynamic, dynamic> json) => Backdrop(
        filePath: json["file_path"] ?? "",
      );

  Map<dynamic, dynamic> toJson() => {
        "file_path": filePath,
      };
}
