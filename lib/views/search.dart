// import 'package:flutter/material.dart';
// import 'package:iconify_flutter/iconify_flutter.dart';
// import 'package:iconify_flutter/icons/tabler.dart';
// import 'package:movies_app/models/movie_model.dart';
// import 'package:movies_app/models/movie_response_model.dart';
// import 'package:movies_app/service/api_service.dart';
// import 'package:movies_app/style/colors.dart';
// import 'package:movies_app/style/font.dart';
// import 'package:movies_app/widgets/custom_input.dart';
// import 'package:movies_app/widgets/custom_title.dart';
// import 'package:movies_app/widgets/horizontal_card.dart';
// import 'package:movies_app/widgets/pre_load_horizontal_card.dart';
//
// class Search extends StatefulWidget {
//   const Search({Key? key}) : super(key: key);
//
//   @override
//   State<Search> createState() => _SearchState();
// }
//
// class _SearchState extends State<Search> {
//   final controller = TextEditingController();
//   final FocusNode focusNode = FocusNode();
//   late Future<List<MovieModel>> items = Future<List<MovieModel>>.value([]);
//
//   @override
//   void initState() {
//     super.initState();
//     items = fetchApiTopRated().then((value) => value.results);
//   }
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   Future<MovieResponseModel> fetchApiTopRated() async {
//     return MovieService.topRated();
//   }
//
//   searchWithName(String name) async {
//     if (controller.text.isNotEmpty && controller.selection.isValid) {
//       String searchText = controller.text;
//       setState(() {
//         items = MovieService.searchByName(searchText);
//       });
//     } else {
//       throw Exception(
//           "Invalid input: The search text is empty or selection is invalid.");
//     }
//     // controller.text == "";
//     focusNode.unfocus();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double totalWidth = MediaQuery.of(context).size.width;
//     double totalHeight = MediaQuery.of(context).size.height;
//     double statusBar = MediaQuery.of(context).padding.top;
//     return Container(
//       color: Pallete.grayDark,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: statusBar,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 20,
//                 vertical: 10,
//               ),
//               child: Column(
//                 children: [
//                   const CustomTitle(text: "Search"),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   SizedBox(
//                     width: (MediaQuery.of(context).size.width) - 40,
//                     child: CustomInput(
//                       controller: controller,
//                       focusNode: focusNode,
//                       searchCallback: searchWithName,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             FutureBuilder<List<MovieModel>>(
//               future: items,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Column(
//                     children: List.generate(
//                       4,
//                       (_) => const Column(
//                         children: [
//                           PreLoadHorizontalCard(),
//                           SizedBox(
//                             height: 10,
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text(
//                     'Ocorreu um erro: ${snapshot.error}',
//                     style: const TextStyle(color: Pallete.white),
//                   );
//                 } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return SizedBox(
//                     height: totalHeight - 200 - statusBar,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Iconify(
//                           Tabler.error_404,
//                           color: Pallete.white,
//                           size: totalWidth / 2,
//                         ),
//                         Text(
//                           'Item não encontrado',
//                           style: StyleFont.bold
//                               .copyWith(fontSize: 20, color: Pallete.white),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//
//                 List<MovieModel> movie = snapshot.data!.toList();
//
//                 return ListView.separated(
//                   padding: const EdgeInsets.all(0),
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: movie.length,
//                   separatorBuilder: (context, index) =>
//                       const SizedBox(height: 10),
//                   itemBuilder: (context, index) {
//                     return HorizontalCard(item: movie[index]);
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
