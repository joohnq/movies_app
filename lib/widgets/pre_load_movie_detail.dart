import 'package:flutter/material.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/widgets/pre_load_credits.dart';

class PreLoadMovieDetail extends StatelessWidget {
  const PreLoadMovieDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    double totalHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Pallete.grayLight,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          height: totalHeight * 0.4,
          child: Container(),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: totalWidth,
          decoration: const BoxDecoration(color: Pallete.grayDark),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Pallete.grayLight,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: totalWidth - 80,
                        height: 25,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: totalWidth * 0.2,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Pallete.grayLight,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 30,
                            width: totalWidth * 0.2,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Pallete.grayLight,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 30,
                            width: totalWidth * 0.2,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Pallete.grayLight,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: totalWidth * 0.4,
                height: 20,
                decoration: BoxDecoration(
                  color: Pallete.grayLight,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: totalWidth,
                height: 100,
                decoration: BoxDecoration(
                  color: Pallete.grayLight,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const PreLoadCredits(),
            ],
          ),
        ),
      ],
    );
  }
}
