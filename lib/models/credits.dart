import 'dart:convert';

CreditsModel creditsFromJson(String str) => CreditsModel.fromJson(json.decode(str));

String creditsToJson(CreditsModel data) => json.encode(data.toJson());

class CreditsModel {
  List<Cast> cast;
  List<Cast> crew;

  CreditsModel({
    required this.cast,
    required this.crew,
  });

  factory CreditsModel.fromJson(Map<dynamic, dynamic> json) => CreditsModel(
    cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
    crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
    "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
  };
}

class Cast {
  String name;
  String originalName;
  String? profilePath;
  String? character;
  String? department;

  Cast({
    required this.name,
    required this.originalName,
    this.profilePath,
    this.character,
    this.department,
  });

  factory Cast.fromJson(Map<dynamic, dynamic> json) => Cast(
    name: json["name"],
    originalName: json["original_name"],
    profilePath: json["profile_path"],
    character: json["character"] ?? "",
    department: json["department"] ?? "",
  );

  Map<dynamic, dynamic> toJson() => {
    "name": name,
    "original_name": originalName,
    "profile_path": profilePath,
    "character": character,
    "department": department,
  };
}
