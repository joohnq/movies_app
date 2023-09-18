import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  List<String> _favorites = [];
  final String _favouritesError = "";
  late SharedPreferences _prefs;

  FavoritesProvider() {
    _loadFavorites();
  }

  List<String> get favorites => _favorites;

  String get favoritesError => _favouritesError;

  int get favoritesCount => _favorites.length;

  Future<void> _loadFavorites() async {
    _prefs = await SharedPreferences.getInstance();
    final favorites = _prefs.getStringList('favorites');
    if (favorites != null) {
      _favorites = favorites;
      notifyListeners();
    }
  }

  Future<void> _saveFavorites() async {
    await _prefs.setStringList('favorites', _favorites);
  }

  void addToFavorites(String favorite) {
    if (!_favorites.contains(favorite)) {
      _favorites.add(favorite);
      _saveFavorites();
      notifyListeners();
    }
  }

  void removeFromFavorites(String favorite) {
    _favorites.remove(favorite);
    _saveFavorites();
    notifyListeners();
  }

  void cleanFavorites() {
    _favorites = <String>[];
    _saveFavorites();
    notifyListeners();
  }

  bool itsFavorite(String favorite) {
    return _favorites.contains(favorite) ? true : false;
  }
}
