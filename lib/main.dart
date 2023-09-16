import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/app.dart';
import 'package:movies_app/controller/favourites_controller.dart';
import 'package:movies_app/views/discover.dart';
import 'package:movies_app/views/movie_detail.dart';
import 'package:provider/provider.dart';

main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesProvider(),
      child: GetMaterialApp(
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
    ),
  );
}
