import 'package:flutter/material.dart';
import 'package:movies_app/controller/movies_trending_controller.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/widgets/custom_input.dart';
import 'package:movies_app/widgets/custom_title.dart';
import 'package:movies_app/widgets/horizontal_card.dart';

class Search extends StatefulWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final _controller = MoviesTrendingController();
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    setState(() {
      _controller.loading = true;
    });

    await _controller.fetchTrending(page: lastPage);

    setState(() {
      _controller.loading = false;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  searchWithName(String title) async {
    await _controller.fetchMoviesByName(title, page: 1);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double statusBar = MediaQuery.of(context).padding.top;
    return Container(
      color: Pallete.grayDark,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: statusBar,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Column(
                children: [
                  const CustomTitle(text: "Search"),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width) - 40,
                    child: CustomInput(
                      controller: controller,
                      focusNode: focusNode,
                      searchCallback: searchWithName,
                    ),
                  ),
                ],
              ),
            ),
            ListView.separated(
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _controller.itemCount,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return HorizontalCard(
                  item: _controller.item[index],
                  mediaType: _controller.mediaType,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
