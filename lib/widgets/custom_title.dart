import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';

class CustomTitle extends StatelessWidget {
  final String text;

  const CustomTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: StyleFont.bold.copyWith(color: Pallete.white, fontSize: 28),
      maxLines: 1,
    );
  }
}
