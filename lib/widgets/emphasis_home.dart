import 'package:flutter/material.dart';
import 'package:movies_app/models/movies_series.dart';
import 'package:movies_app/widgets/emphasis_home_content.dart';
import 'package:movies_app/widgets/future_prompt.dart';
import 'package:movies_app/widgets/pre_load_emphasis_home.dart';

class EmphasisHome extends StatefulWidget {
  final Future<List<Result>> item;

  const EmphasisHome({super.key, required this.item});

  @override
  State<EmphasisHome> createState() => _EmphasisHomeState();
}

class _EmphasisHomeState extends State<EmphasisHome> {
  late bool itsFavourite = false;
  List<String> category = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Result>>(
      future: widget.item,
      builder: (BuildContext context, AsyncSnapshot<List<Result>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const PreLoadEmphasisHome();
        } else if (snapshot.hasError) {
          return CustomFuturePrompt(text: "Ocorreu um erro: $snapshot.error");
        } else if (!snapshot.hasData) {
          return const CustomFuturePrompt(text: "Nenhum dado encontrado");
        }

        Result item = snapshot.data![0];

        return EmphasisHomeContent(item: item);
      },
    );
  }
}
