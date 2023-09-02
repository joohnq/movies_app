import 'package:movies_app/models/backdrop_model.dart';

class MovieImagesModel {
  List<Backdrop> backdrops;

  MovieImagesModel({
    required this.backdrops,
  });

  factory MovieImagesModel.fromJson(Map<dynamic, dynamic> json) =>
      MovieImagesModel(
        backdrops: List<Backdrop>.from(
            json["backdrops"].map((x) => Backdrop.fromJson(x))),
      );

  Map<dynamic, dynamic> toJson() => {
        "backdrops": List<dynamic>.from(backdrops.map((x) => x.toJson())),
      };
}
