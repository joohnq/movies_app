import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/tabler.dart';
import 'package:movies_app/models/categories.dart';
import 'package:movies_app/models/movies_series.dart';
import 'package:movies_app/service/api_service.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';
import 'package:movies_app/widgets/custom_title.dart';
import 'package:movies_app/widgets/pre_load_vertical_card.dart';
import 'package:movies_app/widgets/vertical_card.dart';

class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  State<Discover> createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  late Future<List<Result>> movies = Future<List<Result>>.value([]);
  int page = 1;
  final controller = TextEditingController();
  final FocusScopeNode focusNode = FocusScopeNode();
  int whatIsTrue = 0;
  List<Result> oldMovie = [];

  @override
  void initState() {
    super.initState();
    movies = fetchApiTrending(1).then((value) => value.results);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<MoviesAndSeries> fetchApiTrending(int page) async {
    return MovieService.trending(page);
  }

  loadMoreMovies() async {
    setState(() {
      page++;
    });
    try {
      List<Result> newMovies =
          await MovieService.trending(page).then((value) => value.results);
      List<Result> existingMovies = await movies;
      List<Result> updatedMovies = [...existingMovies, ...newMovies];
      setState(() {
        movies = Future.value(updatedMovies);
      });
    } catch (error) {
      Exception('Erro ao buscar filmes: $error');
    }
  }

  updateWhatIsTrue(int index, String id) {
    if (index != whatIsTrue || index == 0) {
      setState(() {
        movies = searchCategory(id).then((value) => value.results);
        whatIsTrue = index;
      });
    }
  }

  Future<MoviesAndSeries> searchCategory(String category) async {
    return MovieService.searchByCategory(category);
  }

  searchWithName(String name) async {
    if (controller.text.isNotEmpty && controller.selection.isValid) {
      String searchText = controller.text;
      setState(() {
        movies = MovieService.searchByName(searchText);
      });
    } else {
      throw Exception(
          "Invalid input: The search text is empty or selection is invalid.");
    }
    controller.text = "";
    focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double statusBar = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Pallete.grayDark,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.keyboard_arrow_left_rounded,
                            size: 40,
                            color: Pallete.yellow,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const CustomTitle(text: "Discover"),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == whatIsTrue) {
                            return GestureDetector(
                              onTap: () {
                                updateWhatIsTrue(
                                    index, categories[index]['id']);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Pallete.yellow,
                                ),
                                margin: const EdgeInsets.only(right: 10),
                                child: Center(
                                  child: Text(
                                    categories[index]['name'],
                                    style: StyleFont.bold.copyWith(
                                      color: Pallete.grayDark,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                updateWhatIsTrue(
                                    index, categories[index]['id']);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Pallete.grayLight,
                                ),
                                margin: const EdgeInsets.only(right: 10),
                                child: Center(
                                  child: Text(
                                    categories[index]['name'],
                                    style: StyleFont.bold.copyWith(
                                      color: Pallete.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<List<Result>>(
                future: movies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Column(
                      children: [
                        for (var _ in [0, 1])
                          const Column(
                            children: [
                              PreLoadVerticalCard(),
                              SizedBox(height: 20),
                            ],
                          ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      'Ocorreu um erro: ${snapshot.error}',
                      style: const TextStyle(color: Pallete.white),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return SizedBox(
                      height: height - 200 - statusBar,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Iconify(
                            Tabler.error_404,
                            color: Pallete.white,
                            size: width / 2,
                          ),
                          Text(
                            'Item não encontrado',
                            style: StyleFont.bold
                                .copyWith(fontSize: 20, color: Pallete.white),
                          ),
                        ],
                      ),
                    );
                  }
                  List<Result> movie = snapshot.data!.toList();
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 10,
                      childAspectRatio: width / height,
                    ),
                    shrinkWrap: true,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: (movie.length / 2).ceil(),
                    itemBuilder: (context, index) {
                      return VerticalCard(
                        item: movie[index],
                      );
                    },
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  loadMoreMovies();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Pallete.yellow,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "Mostrar mais",
                      style: StyleFont.bold
                          .copyWith(color: Pallete.grayDark, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
