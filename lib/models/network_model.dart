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
        id: json["id"] ?? 0,
        logoPath: json["logo_path"] ?? "",
        name: json["name"] ?? "",
        originCountry: json["origin_country"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo_path": logoPath,
        "name": name,
        "origin_country": originCountry,
      };
}
