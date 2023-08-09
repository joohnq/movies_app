import 'package:flutter/material.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';

class ErrorComponent extends StatelessWidget {
  const ErrorComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error,
          color: Pallete.white,
          size: 30,
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ocorreu um erro",
              style: StyleFont.bold.copyWith(color: Pallete.white),
            ),
            Text(
              "Tente novamente mais tarde",
              style: StyleFont.bold
                  .copyWith(color: Pallete.grayLight, fontSize: 12),
            ),
          ],
        )
      ],
    );
  }
}
