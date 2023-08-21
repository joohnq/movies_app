import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:movies_app/app.dart';
import 'package:movies_app/views/discover.dart';
import 'package:movies_app/views/movie_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future initApp() async {
  await dotenv.load(fileName: ".env");
  final prefs = await SharedPreferences.getInstance();
  // await prefs.clear();
  if (prefs.getStringList('favourites') == null) {
    await prefs.setStringList('favourites', []);
  }
}

main() async {
  await initApp();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const App(),
        ),
        GetPage(
            name: '/moviedetail',
            page: () => const MovieDetail(),
            transition: Transition.rightToLeft),
        GetPage(
            name: '/seemore',
            page: () => const Discover(),
            transition: Transition.rightToLeft),
      ],
    ),
  );
}
