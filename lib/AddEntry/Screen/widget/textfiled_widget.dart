import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {super.key,
      required this.controller,
      required this.title,
      this.suffixWidget,
      this.keyboardType,
      this.hintText});
  final TextEditingController controller;
  final String title;
    final TextInputType? keyboardType;

  final String? hintText;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          clipBehavior: Clip.hardEdge,
          decoration: InputDecoration(hintText: hintText,suffixIcon: suffixWidget),
        ),
      ],
    );
  }
}
