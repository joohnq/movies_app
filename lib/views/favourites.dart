import 'package:flutter/material.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/widgets/custom_title.dart';

class Favourites extends StatelessWidget {
  const Favourites({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Pallete.grayDark,
      child: const SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              CustomTitle(text: "Favourites"),
            ],
          ),
        ),
      ),
    );
  }
}
