import 'dart:convert';

List<FavoriteModel> favoritesModelFromJson(String str) =>
    List<FavoriteModel>.from(
        json.decode(str).map((x) => FavoriteModel.fromJson(x)));

String favoritesModelToJson(List<FavoriteModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavoriteModel {
  String id;
  String mediaType;

  FavoriteModel({
    required this.id,
    required this.mediaType,
  });

  factory FavoriteModel.fromJson(Map<dynamic, dynamic> json) => FavoriteModel(
        id: json["id"] ?? "",
        mediaType: json["mediaType"] ?? "",
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "mediaType": mediaType,
      };
}
