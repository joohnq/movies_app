import 'package:flutter/material.dart';
import 'package:movies_app/style/colors.dart';

class PreLoadVerticalCard extends StatelessWidget {
  const PreLoadVerticalCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width;
    final totalHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: 300,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                Container(
                  height: totalHeight,
                  width: totalWidth / 2 - 20,
                  decoration: BoxDecoration(
                    color: Pallete.preLoad,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Pallete.grayLight,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 20),
            width: totalWidth / 2 - 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 15,
                  width: totalWidth * 0.4,
                  decoration: BoxDecoration(
                    color: Pallete.grayLight,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 15,
                  width: totalWidth * 0.2,
                  decoration: BoxDecoration(
                    color: Pallete.grayLight,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 15,
                      width: totalWidth * 0.15,
                      decoration: BoxDecoration(
                        color: Pallete.grayLight,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 15,
                      width: totalWidth * 0.15,
                      decoration: BoxDecoration(
                        color: Pallete.grayLight,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 15,
                  width: totalWidth * 0.8,
                  decoration: BoxDecoration(
                    color: Pallete.grayLight,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 15,
                  width: totalWidth * 0.3,
                  decoration: BoxDecoration(
                    color: Pallete.grayLight,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 15,
                  width: totalWidth * 0.2,
                  decoration: BoxDecoration(
                    color: Pallete.grayLight,
                    borderRadius: BorderRadius.circular(5),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
