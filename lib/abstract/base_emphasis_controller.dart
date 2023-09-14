abstract class BaseEmphasisController {
  bool loading = false;
  bool get hasEmphasis;
  String get backdropPath;
  int get id;
  String get originalTitle;
  String get originalName;
  String get title;
  String get name;
  double get voteAverage;
  String get mediaType;

  Future<void> fetchEmphasis({int page = 1});
}
