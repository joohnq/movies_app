import 'package:movies_app/models/cast_model.dart';

class MovieCreditsModel {
  List<Cast> cast;
  List<Cast> crew;

  MovieCreditsModel({
    required this.cast,
    required this.crew,
  });

  factory MovieCreditsModel.fromJson(Map<dynamic, dynamic> json) =>
      MovieCreditsModel(
        cast: json["cast"] != null
            ? List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x)))
            : <Cast>[],
        crew: json["crew"] != null
            ? List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x)))
            : <Cast>[],
      );

  Map<dynamic, dynamic> toJson() => {
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
      };
}
