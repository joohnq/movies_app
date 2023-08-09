import 'package:flutter/material.dart';
import 'package:movies_app/models/movies_series.dart';
import 'package:movies_app/service/api_service.dart';
import 'package:movies_app/service/preferences_service.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/widgets/custom_title.dart';
import 'package:movies_app/widgets/pre_load_vertical_card.dart';
import 'package:movies_app/widgets/vertical_card.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  late Future<List<Result>> favourites;

  @override
  void initState() {
    super.initState();
    loadFavourites();
  }

  Future<void> loadFavourites() async {
    List<String> cacheIds = await PreferencesService.getFavourites();
    List<Result> favourites = await MovieService.getWithIds(cacheIds);

    setState(() {
      favourites = favourites;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double statusBar = MediaQuery.of(context).padding.top;
    return Container(
      color: Pallete.grayDark,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: statusBar,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: CustomTitle(text: "Salvos"),
            ),
            FutureBuilder<List<Result>>(
              future: favourites,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: List.generate(
                      2,
                      (_) => const Column(
                        children: [
                          PreLoadVerticalCard(),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'Ocorreu um erro: ${snapshot.error}',
                    style: const TextStyle(color: Pallete.white),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: SizedBox(
                      height: height - 200 - statusBar,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Você não tem itens salvos.',
                            style: StyleFont.bold
                                .copyWith(fontSize: 20, color: Pallete.white),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                List<Result> favourites = snapshot.data!.toList();
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: width / height,
                    crossAxisSpacing: 10.0,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: favourites.length,
                  itemBuilder: (context, index) {
                    return VerticalCard<Result>(
                      item: favourites[index],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
