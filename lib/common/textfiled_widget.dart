import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Values/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {super.key,
      this.controller,
      required this.title,
      this.suffixWidget,
      this.keyboardType,
      this.readOnly,
      this.labelText,
      this.onTap,
      this.maxLines,
      this.onChanged,
      this.inpurborder,
      this.hintText});

  final TextEditingController? controller;
  final String title;
  final TextInputType? keyboardType;
  ValueChanged<String>? onChanged;
  final bool? readOnly;
  final GestureTapCallback? onTap;
  final String? hintText;
  final String? labelText;
  final InputBorder? inpurborder;
  final Widget? suffixWidget;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        TextField(
          maxLines: maxLines,
          controller: controller,
          readOnly: readOnly ?? false,
          keyboardType: keyboardType,
          clipBehavior: Clip.hardEdge,
          onChanged: onChanged,
          onTap: onTap,
          decoration: InputDecoration(
              border: inpurborder,
              hintText: hintText,
              labelText: labelText,
              labelStyle: GoogleFonts.poppins(
                  color: AppColor.naturalBlackColor, fontSize: 14),
              suffixIcon: suffixWidget),
        ),
      ],
    );
  }
}
