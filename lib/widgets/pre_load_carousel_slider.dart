import 'package:flutter/material.dart';
import 'package:movies_app/style/colors.dart';

class PreLoadCarouselSlider extends StatelessWidget {
  const PreLoadCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 200,
                    width: 140,
                    decoration: BoxDecoration(
                      color: Pallete.grayDark,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
