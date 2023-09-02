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
        name: json["name"] ?? "",
        originalName: json["original_name"] ?? "",
        profilePath: json["profile_path"] ?? "",
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
