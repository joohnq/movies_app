class FavouritesService {
  static changeFavouriteStatus() {
    // static Future changeFavouriteStatus(
    //   Map<String, String> item, bool itsFavourite) async {
    // final List<Map<String, String>> cache =
    //     await PreferencesService.getFavourites();
    // if (itsFavourite) {
    //   cache.add(json.encode(item));
    // } else {
    //   cache.add(json.encode(item));
    // }
    // await PreferencesService.saveFavourites(cache);
  }

  static Future<bool> getIfIsAlreadyFavourite(id) async {
    // final List<Map<String, String>> cache =
    //     await PreferencesService.getFavourites();
    // for (String item in cache) {
    //   if (item == id) {
    //     return true;
    //   }
    // }

    return false;
  }
}
