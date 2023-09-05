import 'package:flutter/material.dart';
import 'package:movies_app/controller/movies_popular_controller.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/widgets/custom_input.dart';
import 'package:movies_app/widgets/custom_title.dart';
import 'package:movies_app/widgets/horizontal_card.dart';

class Search extends StatefulWidget {
  final MoviesPopularController controllerPopular;

  const Search({
    Key? key,
    required this.controllerPopular,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  _initialize() async {
    setState(() {
      widget.controllerPopular.loading = true;
    });

    await widget.controllerPopular.fetchPopularMovies(page: lastPage);

    setState(() {
      widget.controllerPopular.loading = false;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  searchWithName(String name) async {
    // if (controller.text.isNotEmpty && controller.selection.isValid) {
    //   String searchText = controller.text;
    // } else {
    //   throw Exception(
    //       "Invalid input: The search text is empty or selection is invalid.");
    // }
    // focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    // double totalWidth = MediaQuery.of(context).size.width;
    // double totalHeight = MediaQuery.of(context).size.height;
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
              itemCount: widget.controllerPopular.itemCount,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return HorizontalCard(
                    item: widget.controllerPopular.item[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
