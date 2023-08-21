import 'package:flutter/material.dart';
import 'package:movies_app/style/colors.dart';
import 'package:movies_app/style/font.dart';

class CustomInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) searchCallback;

  const CustomInput({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.searchCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(
        constraints: const BoxConstraints(maxHeight: 56),
        filled: true,
        fillColor: Pallete.grayLight,
        hintText: "Search",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2.5),
          borderSide: BorderSide.none,
        ),
        hintStyle:
            StyleFont.regular.copyWith(color: Pallete.white, fontSize: 18),
        suffixIcon: GestureDetector(
          onTap: () {
            searchCallback(controller.text);
          },
          child: const Icon(
            Icons.search_rounded,
            size: 30,
            color: Pallete.white,
          ),
        ),
      ),
      style: StyleFont.bold.copyWith(color: Pallete.white, fontSize: 20),
    );
  }
}
