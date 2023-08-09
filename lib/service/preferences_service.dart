import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static Future<List<String>> getFavourites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return [];
    // return prefs.getStringList('favourites') ?? [];
  }

  static Future saveFavourites(List<String> favourites) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favourites', favourites);
  }
}
