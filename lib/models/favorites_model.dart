import 'dart:convert';

List<FavouriteModel> favouritesModelFromJson(String str) =>
    List<FavouriteModel>.from(
        json.decode(str).map((x) => FavouriteModel.fromJson(x)));

String favouritesModelToJson(List<FavouriteModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavouriteModel {
  String id;
  String mediaType;

  FavouriteModel({
    required this.id,
    required this.mediaType,
  });

  factory FavouriteModel.fromJson(Map<dynamic, dynamic> json) => FavouriteModel(
        id: json["id"] ?? "",
        mediaType: json["mediaType"] ?? "",
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "mediaType": mediaType,
      };
}
