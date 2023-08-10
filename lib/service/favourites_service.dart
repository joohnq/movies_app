// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:movies_app/service/preferences_service.dart';

class FavouritesService {
  static Future changeFavouriteStatus(String item, bool itsFavourite) async {
    final List<String> cache = await PreferencesService.getFavourites();
    List itemDecoded = json.decode(item);

    if (itsFavourite) {
      if (!cache.contains(item)) {
        cache.add(item);
      }
    } else {
      cache.removeWhere((e) => json.decode(e)[0] == itemDecoded[0]);
    }
    print(cache);
    await PreferencesService.saveFavourites(cache);
  }

  static Future<bool> getIfIsAlreadyFavourite(String id) async {
    final List<String> cache = await PreferencesService.getFavourites();
    final List<List<dynamic>> cacheDecoded = [];

    for (String item in cache) {
      cacheDecoded.add(json.decode(item));
    }

    for (List<dynamic> element in cacheDecoded) {
      if (element.isNotEmpty && element[0] == id) {
        return true;
      }
    }
    return false;
  }
}
