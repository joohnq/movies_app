import 'package:movies_app/models/backdrop_model.dart';
import 'package:movies_app/models/cast_model.dart';
import 'package:movies_app/models/genre_model.dart';
import 'package:movies_app/models/network_model.dart';
import 'package:movies_app/models/season_model.dart';

abstract class BaseDetailController {
  int get budget;
  List<Cast> get cast;
  bool creditsLoading = false;
  List<Cast> get crew;
  bool detailLoading = false;
  List<Genre> get genres;
  List<Backdrop> get images;
  int get imagesCount;
  bool imagesLoading = false;
  String get mediaType;
  String get name;
  List<Network> get networks;
  String get originalLanguage;
  String get originalName;
  String get originalTitle;
  String get overview;
  String get posterPath;
  String get releaseDate;
  int get runtime;
  List<Season> get seasons;
  String get title;
  String get voteAverage;

  Future<void> fetchById(int id, String title);
  Future<void> fetchImages(int id);
  Future<void> fetchCredits(int id);
}
