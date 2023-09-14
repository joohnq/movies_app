abstract class BaseEmphasisController {
  String get backdropPath;
  bool get hasEmphasis;
  int get id;
  bool loading = false;
  String get mediaType;
  String get name;
  String get originalName;
  String get originalTitle;
  String get overview;
  String get title;
  double get voteAverage;

  Future<void> fetchEmphasis({int page = 1});
}
