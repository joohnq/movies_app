import 'package:movies_app/models/backdrop_model.dart';
import 'package:movies_app/models/cast_model.dart';
import 'package:movies_app/models/genre_model.dart';
import 'package:movies_app/models/network_model.dart';
import 'package:movies_app/models/season_model.dart';

abstract class BaseDetailController {
  bool detailLoading = false;
  bool imagesLoading = false;
  bool creditsLoading = false;
  int get budget;
  List<Genre> get genres;
  String get originalLanguage;
  String get originalTitle;
  String get originalName;
  String get overview;
  String get posterPath;
  String get releaseDate;
  int get runtime;
  String get title;
  String get name;
  String get voteAverage;
  String get mediaType;
  List<Backdrop> get images;
  int get imagesCount;
  List<Cast> get cast;
  List<Cast> get crew;
  List<Network>? get networks;
  List<Season>? get seasons;

  Future<void> fetchById(int id, String title);
  Future<void> fetchImages(int id);
  Future<void> fetchCredits(int id);
}
