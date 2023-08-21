import 'package:flutter/material.dart';
import 'package:movies_app/style/colors.dart';

class PreLoadVerticalCard extends StatelessWidget {
  const PreLoadVerticalCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: width * 0.64,
                width: width,
                decoration: BoxDecoration(
                  color: Pallete.preLoad,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Pallete.grayLight,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: 10,
                child: Container(
                  height: 20,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Pallete.grayLight,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
