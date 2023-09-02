import 'package:flutter/material.dart';
import 'package:movies_app/style/colors.dart';

class PreLoadEmphasisHome extends StatelessWidget {
  const PreLoadEmphasisHome({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    double statusBar = MediaQuery.of(context).padding.top;
    return Container(
      height: height * 0.5,
      width: width,
      constraints: const BoxConstraints(maxHeight: 500),
      child: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(color: Pallete.preLoad),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width,
                    height: 30,
                    constraints: const BoxConstraints(maxWidth: 300),
                    decoration: BoxDecoration(
                      color: Pallete.grayLight,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: width * 0.25,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Pallete.grayLight,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: statusBar + 10,
            child: Column(
              children: [
                const SizedBox(height: 5),
                Container(
                  width: 30,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Pallete.grayLight,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
