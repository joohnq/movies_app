import 'dart:convert';

List<FavouriteModel> favouritesModelFromJson(String str) =>
    List<FavouriteModel>.from(
        json.decode(str).map((x) => FavouriteModel.fromJson(x)));

String favouritesModelToJson(List<FavouriteModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavouriteModel {
  int id;
  String mediaType;
  String title;

  FavouriteModel({
    required this.id,
    required this.mediaType,
    required this.title,
  });

  factory FavouriteModel.fromJson(Map<dynamic, dynamic> json) => FavouriteModel(
        id: json["id"] ?? 0,
        mediaType: json["mediaType"] ?? "",
        title: json["title"] ?? "",
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "mediaType": mediaType,
        "title": title,
      };
}
