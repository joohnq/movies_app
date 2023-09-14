class Cast {
  String? character;
  String? department;
  String name;
  String originalName;
  String? profilePath;

  Cast({
    this.character,
    this.department,
    required this.name,
    required this.originalName,
    this.profilePath,
  });

  factory Cast.fromJson(Map<dynamic, dynamic> json) => Cast(
        character: json["character"] ?? "",
        department: json["department"] ?? "",
        name: json["name"] ?? "",
        originalName: json["original_name"] ?? "",
        profilePath: json["profile_path"] ?? "",
      );

  Map<dynamic, dynamic> toJson() => {
        "character": character,
        "department": department,
        "name": name,
        "original_name": originalName,
        "profile_path": profilePath,
      };
}
