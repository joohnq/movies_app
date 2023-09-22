import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movies_app/models/favorites_model.dart';
import 'package:movies_app/models/movie_and_serie_detail_model.dart';
import 'package:movies_app/repository/repositories.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  final _repository = MovieRepository();

  List<String> _favorites = [];
  String _favoritesError = "";
  late SharedPreferences _prefs;
  final List<MovieAndSerieDetailModel> _favoritesFetched =
      <MovieAndSerieDetailModel>[];

  FavoritesProvider() {
    _loadFavorites();
  }

  List<String> get favorites => _favorites;

  List<MovieAndSerieDetailModel> get favoritesFetched => _favoritesFetched;

  String get favoritesError => _favoritesError;

  int get favoritesCount => _favorites.length;

  Future<void> _loadFavorites() async {
    _prefs = await SharedPreferences.getInstance();
    final favorites = _prefs.getStringList('favorites');
    if (favorites != null) {
      _favorites = favorites;
      for (String favorite in _favorites) {
        _fetchFavorite(favorite);
      }
      notifyListeners();
    }
  }

  Future<void> _saveFavorites() async {
    await _prefs.setStringList('favorites', _favorites);
  }

  void addToFavorites(String favorite) async {
    // ignore: avoid_print
    print('entrou');
    // ignore: avoid_print
    print(favorite);
    if (!_favorites.contains(favorite)) {
      _favorites.add(favorite);
      _saveFavorites();
      _fetchFavorite(favorite);
      notifyListeners();
    }
  }

  void removeFromFavorites(String favorite) {
    _favorites.remove(favorite);
    _saveFavorites();
    FavoriteModel item = _toFavoriteModel(favorite);
    _favoritesFetched.removeWhere(
      (MovieAndSerieDetailModel favorite) =>
          favorite.id.toString() == item.id &&
          favorite.mediaType == item.mediaType,
    );
    notifyListeners();
  }

  void cleanFavorites() {
    _favorites = <String>[];
    _saveFavorites();
    _favoritesFetched.clear();
    notifyListeners();
  }

  bool itsFavorite(String favorite) {
    return _favorites.contains(favorite) ? true : false;
  }

  _fetchFavorite(favorite) async {
    FavoriteModel item = _toFavoriteModel(favorite);
    final result =
        await _repository.fetchFavourite(int.parse(item.id), item.mediaType);
    result.fold(
      (error) => _favoritesError = error.toString(),
      (detail) => {
        _favoritesFetched.add(detail),
      },
    );
    notifyListeners();
  }

  FavoriteModel _toFavoriteModel(String favorite) {
    Map<dynamic, dynamic> jsonData = json.decode(favorite);
    return FavoriteModel(
      id: jsonData['id'],
      mediaType: jsonData['mediaType'],
    );
  }
}
