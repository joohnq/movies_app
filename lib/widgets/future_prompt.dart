import 'package:flutter/material.dart';
import 'package:movies_app/style/colors.dart';

class CustomFuturePrompt extends StatelessWidget {
  final String text;
  const CustomFuturePrompt({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Pallete.white),
    );
  }
}
