import 'package:flutter/material.dart';
import 'package:movies_app/style/colors.dart';

class PreLoadHorizontalCard extends StatelessWidget {
  const PreLoadHorizontalCard({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Pallete.preLoad,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 120,
            width: width / 2 - 20,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            width: width / 2 - 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Pallete.preLoad,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 20,
                  width: (width / 2 - 20) * 0.8,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Pallete.preLoad,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 30,
                  width: (width / 2 - 20) * 0.5,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
