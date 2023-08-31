import 'package:movies_app/models/cast.dart';

class Credits {
  List<Cast> cast;
  List<Cast> crew;

  Credits({
    required this.cast,
    required this.crew,
  });

  factory Credits.fromJson(Map<dynamic, dynamic> json) => Credits(
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
      };
}
